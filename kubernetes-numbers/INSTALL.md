# Kubernetes Installation

**HA Kubernetes cluster on Ubuntu 26.04 LTS** with **3 control-plane nodes** (stacked etcd), **Keepalived + HAProxy** for a virtual IP (VIP), and **2+ worker nodes**.

This follows the official kubeadm stacked control-plane topology + the community keepalived/haproxy pattern.

### Prerequisites / Assumptions

- All nodes: Ubuntu 26.04 LTS, same major version of kubeadm/kubelet/kubectl.
- Nodes on the **same L2 subnet** (required for Keepalived VRRP/VIP).
- Example IPs (replace with yours):

  | Role          | Hostname     | IP            |
  |---------------|--------------|---------------|
  | Control plane | cp1          | 10.0.0.11     |
  | Control plane | cp2          | 10.0.0.12     |
  | Control plane | cp3          | 10.0.0.13     |
  | VIP           | —            | 10.0.0.100    |
  | Workers       | worker1…     | 10.0.0.21…    |

- HAProxy listens on **8443** (frontend) → backends on **6443**.
- ControlPlaneEndpoint = `10.0.0.100:8443`.
- Pod CIDR example: `10.244.0.0/16` (Calico/Flannel friendly). Adjust as needed.
- Root or sudo on all nodes; passwordless SSH recommended for convenience.

---

### 1. Prepare **every** node (control planes + workers)

```bash
# Disable swap
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Kernel modules & sysctl
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF
sudo sysctl --system

# Install containerd
sudo apt update
sudo apt install -y containerd
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl enable containerd

# Kubernetes repo (pkgs.k8s.io)
sudo apt install -y apt-transport-https ca-certificates curl gpg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl enable kubelet
```

(Adjust the version path `v1.32` to the Kubernetes version you want.)

---

### 2. Install & configure Keepalived + HAProxy **only on the 3 control-plane nodes**

```bash
sudo apt install -y keepalived haproxy
```

#### HAProxy (`/etc/haproxy/haproxy.cfg`) — identical on all 3

```bash
sudo tee /etc/haproxy/haproxy.cfg <<EOF
global
    log /dev/log local0
    chroot /var/lib/haproxy
    stats socket /run/haproxy/admin.sock mode 660 level admin
    stats timeout 30s
    user haproxy
    group haproxy
    daemon

defaults
    mode tcp
    log global
    option tcplog
    option dontlognull
    timeout connect 5000
    timeout client  50000
    timeout server  50000

frontend kubernetes-apiserver
    bind *:8443
    mode tcp
    option tcplog
    default_backend k8s-apiserver

backend k8s-apiserver
    mode tcp
    balance roundrobin
    option tcp-check
    server cp1 10.0.0.11:6443 check fall 3 rise 2
    server cp2 10.0.0.12:6443 check fall 3 rise 2
    server cp3 10.0.0.13:6443 check fall 3 rise 2
EOF
```

```bash
sudo systemctl enable --now haproxy
sudo systemctl restart haproxy
```

#### Keepalived

**Health-check script** (identical on all 3):

```bash
sudo tee /etc/keepalived/check_apiserver.sh <<'EOF'
#!/bin/bash
errorExit() {
  echo "*** $*" 1>&2
  exit 1
}
curl -sfk --max-time 2 https://localhost:8443/healthz -o /dev/null || errorExit "Error GET https://localhost:8443/healthz"
EOF
sudo chmod +x /etc/keepalived/check_apiserver.sh
```

**keepalived.conf** — differ only in `state` and `priority`:

- **cp1** (MASTER, priority 110):

```bash
sudo tee /etc/keepalived/keepalived.conf <<EOF
global_defs {
  router_id LVS_DEVEL
  script_user root
  enable_script_security
}

vrrp_script check_apiserver {
  script "/etc/keepalived/check_apiserver.sh"
  interval 3
  weight -2
  fall 10
  rise 2
}

vrrp_instance VI_1 {
  state MASTER
  interface eth0          # <-- change to your interface (ip a)
  virtual_router_id 51
  priority 110
  advert_int 1
  authentication {
    auth_type PASS
    auth_pass K8sHASecret
  }
  virtual_ipaddress {
    10.0.0.100
  }
  track_script {
    check_apiserver
  }
}
EOF
```

- **cp2**: `state BACKUP`, `priority 100`
- **cp3**: `state BACKUP`, `priority 90`

```bash
sudo systemctl enable --now keepalived
sudo systemctl restart keepalived
```

Verify VIP is present on the MASTER:

```bash
ip addr show | grep 10.0.0.100
```

Test:

```bash
nc -zv 10.0.0.100 8443   # connection refused is OK before kube-apiserver exists
```

---

### 3. Initialize the first control plane (cp1)

Create config:

```bash
cat <<EOF | tee kubeadm-config.yaml
apiVersion: kubeadm.k8s.io/v1beta4
kind: ClusterConfiguration
kubernetesVersion: stable
controlPlaneEndpoint: "10.0.0.100:8443"
networking:
  podSubnet: "10.244.0.0/16"
  serviceSubnet: "10.96.0.0/12"
apiServer:
  certSANs:
  - "10.0.0.100"
  - "10.0.0.11"
  - "10.0.0.12"
  - "10.0.0.13"
  - "127.0.0.1"
---
apiVersion: kubeadm.k8s.io/v1beta4
kind: InitConfiguration
localAPIEndpoint:
  advertiseAddress: "10.0.0.11"
  bindPort: 6443
nodeRegistration:
  criSocket: unix:///var/run/containerd/containerd.sock
---
apiVersion: kubelet.config.k8s.io/v1beta1
kind: KubeletConfiguration
cgroupDriver: systemd
EOF
```

```bash
sudo kubeadm init --config kubeadm-config.yaml --upload-certs
```

Save the **join commands** (control-plane and worker) that appear in the output.

Configure kubectl on cp1:

```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

Install a CNI (example Calico):

```bash
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.29.1/manifests/calico.yaml
# or use the version matching your needs
```

Wait until CoreDNS and CNI pods are Running.

---

### 4. Join the other two control-plane nodes

On **cp2** and **cp3** run the control-plane join command from the `kubeadm init` output, e.g.:

```bash
sudo kubeadm join 10.0.0.100:8443 \
  --token <token> \
  --discovery-token-ca-cert-hash sha256:<hash> \
  --control-plane --certificate-key <cert-key>
```

(If the certificate key expired, regenerate on cp1: `sudo kubeadm init phase upload-certs --upload-certs`)

After joining, rebalance CoreDNS if desired:

```bash
kubectl -n kube-system rollout restart deployment coredns
```

---

### 5. Join worker nodes

On each worker:

```bash
sudo kubeadm join 10.0.0.100:8443 \
  --token <token> \
  --discovery-token-ca-cert-hash sha256:<hash>
```

---

### 6. Verification

```bash
kubectl get nodes -o wide
kubectl get pods -n kube-system
kubectl get cs   # or componentstatuses (deprecated but still useful)

# etcd health (from a control-plane node)
kubectl exec -n kube-system etcd-cp1 -- etcdctl \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  endpoint health --cluster

# Test VIP failover
# On the node that currently owns the VIP:
sudo systemctl stop keepalived
# Check that VIP moved and API is still reachable:
curl -k https://10.0.0.100:8443/healthz
```

---

### Notes & tips

- **Interface name**: Replace `eth0` with the real interface (`ip a`).
- **Firewall**: Open 6443, 8443, 2379-2380, 10250, 10259, 10257, CNI ports, etc. between nodes.
- Prefer the official docs for upgrades and production hardening:  
  https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/
- Alternative: **kube-vip** (single binary that can replace keepalived+haproxy) is also popular.
- Ubuntu 26.04 packages may have slightly different defaults; if containerd or kubelet fails, check `journalctl -u containerd` / `journalctl -u kubelet`.

