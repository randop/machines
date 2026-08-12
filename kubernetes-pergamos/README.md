# pergamos

## Scoped kubectl Access via CSR API

No `admin.conf` distribution. Client cert signed by the cluster CA through the built-in CertificateSigningRequest API. CA private key never leaves the control plane.

### Prerequisites

- Existing admin access to the cluster (from a control-plane node, or temporary `admin.conf`) to approve the CSR and bind RBAC.
- Cluster reachable at `https://pergamos.tindango:8443`.

### 1. Workstation — generate key and CSR

```bash
mkdir -p ~/.kube && cd ~/.kube
openssl genrsa -out devsecops.key 2048
openssl req -new -key devsecops.key -out devsecops.csr -subj "/CN=devsecops/O=devops"
```

`CN` is the Kubernetes username. `O` is the RBAC group.

### 2. Submit CSR to the cluster

Run where admin access is available:

```bash
cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: devsecops
spec:
  request: $(cat devsecops.csr | base64 | tr -d '\n')
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - client auth
  expirationSeconds: 31536000
EOF
```

### 3. Approve and fetch the signed cert

```bash
kubectl certificate approve devsecops
kubectl get csr devsecops -o jsonpath='{.status.certificate}' | base64 -d > devsecops.crt
```

### 4. Fetch the CA cert

```bash
kubectl config view --raw -o jsonpath='{.clusters[0].cluster.certificate-authority-data}' | base64 -d > ca.crt
```

Copy `devsecops.crt` and `ca.crt` to the workstation's `~/.kube/`, alongside `devsecops.key`.

### 5. Workstation — build the kubeconfig

```bash
cd ~/.kube

kubectl config set-cluster mycluster \
  --certificate-authority=ca.crt --embed-certs=true \
  --server=https://pergamos.tindango:8443 \
  --kubeconfig=config

kubectl config set-credentials devsecops \
  --client-certificate=devsecops.crt --client-key=devsecops.key --embed-certs=true \
  --kubeconfig=config

kubectl config set-context devsecops@mycluster \
  --cluster=mycluster --user=devsecops \
  --kubeconfig=config

kubectl config use-context devsecops@mycluster --kubeconfig=config
```

This writes directly to `~/.kube/config`. If a kubeconfig already exists there, merge contexts instead of overwriting:

```bash
KUBECONFIG=~/.kube/config:~/.kube/config.new kubectl config view --flatten > ~/.kube/config.merged
mv ~/.kube/config.merged ~/.kube/config
```

### 6. Grant RBAC

Run once, with admin access:

```bash
kubectl create clusterrolebinding devsecops-admin \
  --clusterrole=admin --user=devsecops
```

Cluster-wide `admin` role, all resources except cluster-scoped objects (nodes, PVs, etc.), across all namespaces. Adjust as needed:

- `--clusterrole=edit` or `--clusterrole=view` for less access
- `kubectl create rolebinding` instead of `clusterrolebinding` to restrict to one namespace
- A custom `ClusterRole` for fine-grained resource/verb scoping

### 7. Verify

```bash
kubectl get pods -A
kubectl auth can-i delete nodes --as=devsecops
```

### Renewal

Cert expires per `expirationSeconds` (365 days above). No auto-rotation for manually issued client certs. Re-run steps 1–5 before expiry.
