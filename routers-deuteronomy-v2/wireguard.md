Setting up NAT traversal for WireGuard on Arch Linux to bypass Carrier-Grade NAT (CGNAT) involves creating a VPN tunnel between a home server behind CGNAT and a VPS with a public IP. This allows external access to your local network services. Below is a step-by-step guide tailored for Arch Linux.

---

### Prerequisites
1. **A VPS with a public IP**: Choose a provider like Vultr, Linode, or DigitalOcean. Ensure the VPS has no firewall restrictions blocking WireGuard ports (e.g., 51820/UDP).
2. **Arch Linux home server**: A device on your CGNAT network (e.g., a Raspberry Pi or PC running Arch Linux).
3. **WireGuard installed**: On both the VPS and home server.
4. **Basic Linux knowledge**: Familiarity with terminal commands and networking concepts.

---

### Step 1: Install WireGuard on Arch Linux
On both the VPS and home server, install WireGuard and its tools:

```bash
sudo pacman -Syu wireguard-tools
```

If your kernel doesn’t include the WireGuard module, install it:

```bash
sudo pacman -S wireguard-dkms
```

Verify installation:

```bash
modprobe wireguard
lsmod | grep wireguard
```

---

### Step 2: Generate Key Pairs
Generate private and public keys for both the VPS and home server.

On the VPS:

```bash
umask 077
wg genkey | tee /etc/wireguard/privatekey | wg pubkey > /etc/wireguard/publickey
```

On the home server:

```bash
umask 077
wg genkey | tee /etc/wireguard/privatekey | wg pubkey > /etc/wireguard/publickey
```

Note down the public keys (`/etc/wireguard/publickey`) and private keys (`/etc/wireguard/privatekey`) for both devices.

---

### Step 3: Configure WireGuard on the VPS
Create a WireGuard configuration file on the VPS at `/etc/wireguard/wg0.conf`:

```bash
[Interface]
Address = 10.0.0.1/24
ListenPort = 51820
PrivateKey = <VPS_PRIVATE_KEY>
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

[Peer]
PublicKey = <HOME_SERVER_PUBLIC_KEY>
AllowedIPs = 10.0.0.2/32, 192.168.1.0/24
PersistentKeepalive = 25
```

- **Address**: Assigns a private IP for the WireGuard interface.
- **ListenPort**: The UDP port for WireGuard (51820 is default; adjust if needed).
- **PrivateKey**: The VPS’s private key.
- **PostUp/PostDown**: Enable NAT and forwarding for traffic to the home network.
- **AllowedIPs**: Includes the home server’s WireGuard IP (`10.0.0.2`) and the home LAN subnet (`192.168.1.0/24`, adjust to your LAN subnet).
- **PersistentKeepalive**: Keeps the connection alive through CGNAT.

Replace `<VPS_PRIVATE_KEY>` and `<HOME_SERVER_PUBLIC_KEY>` with the keys generated earlier. Replace `eth0` with your VPS’s network interface (check with `ip link`).

---

### Step 4: Configure WireGuard on the Home Server
Create a WireGuard configuration file on the home server at `/etc/wireguard/wg0.conf`:

```bash
[Interface]
Address = 10.0.0.2/24
PrivateKey = <HOME_SERVER_PRIVATE_KEY>
DNS = 1.1.1.1
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

[Peer]
PublicKey = <VPS_PUBLIC_KEY>
Endpoint = <VPS_PUBLIC_IP>:51820
AllowedIPs = 0.0.0.0/0
PersistentKeepalive = 25
```

- **Address**: The home server’s WireGuard IP.
- **PrivateKey**: The home server’s private key.
- **DNS**: Optional, sets a DNS server (e.g., Cloudflare’s 1.1.1.1).
- **PostUp/PostDown**: Enable NAT and forwarding for local traffic.
- **Endpoint**: The VPS’s public IP and port.
- **AllowedIPs**: `0.0.0.0/0` routes all traffic through the VPS (modify if you only want specific subnets).
- **PersistentKeepalive**: Ensures the tunnel remains open through CGNAT.

Replace `<HOME_SERVER_PRIVATE_KEY>`, `<VPS_PUBLIC_KEY>`, and `<VPS_PUBLIC_IP>` with the appropriate values. Replace `eth0` with your home server’s network interface.

---

### Step 5: Enable IP Forwarding
Enable IP forwarding on both the VPS and home server to allow traffic routing.

On both devices, edit `/etc/sysctl.conf` (or a file in `/etc/sysctl.d/`):

```bash
echo "net.ipv4.ip_forward=1" | sudo tee /etc/sysctl.d/99-sysctl.conf
sudo sysctl -p /etc/sysctl.d/99-sysctl.conf
```

---

### Step 6: Start WireGuard
On both the VPS and home server, enable and start the WireGuard service:

```bash
sudo systemctl enable wg-quick@wg0.service
sudo systemctl start wg-quick@wg0.service
```

Verify the tunnel is active:

```bash
sudo wg show
```

You should see a “latest handshake” and data transfer between the peers.

---

### Step 7: Forward Specific Ports (Optional)
To expose specific services (e.g., a web server on port 80) on your home server, add iptables rules on the VPS. For example, to forward HTTP traffic:

```bash
sudo iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j DNAT --to-destination 10.0.0.2:80
sudo iptables -t nat -A POSTROUTING -o wg0 -p tcp --dport 80 -d 10.0.0.2 -j SNAT --to-source 10.0.0.1
sudo iptables -A FORWARD -i eth0 -o wg0 -p tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A FORWARD -i wg0 -o eth0 -p tcp --sport 80 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
```

- Replace `10.0.0.2` with the home server’s WireGuard IP.
- Replace `eth0` with the VPS’s network interface.
- Adjust the port (`80`) to match your service (e.g., `22` for SSH).

To make these rules persistent, install `iptables-persistent`:

```bash
sudo pacman -S iptables-persistent
sudo iptables-save > /etc/iptables/iptables.rules
sudo systemctl enable iptables
```

---

### Step 8: Firewall Configuration
Ensure the VPS’s firewall allows WireGuard traffic. If using `ufw`:

```bash
sudo ufw allow 51820/udp
```

If your VPS provider has a cloud firewall, ensure port 51820/UDP and any forwarded ports (e.g., 80) are open.

---

### Step 9: Test the Setup
1. **Ping Test**: From the VPS, ping the home server’s WireGuard IP:

```bash
ping 10.0.0.2
```

2. **Access Services**: If you forwarded ports (e.g., 80), access the service via the VPS’s public IP in a browser (e.g., `http://<VPS_PUBLIC_IP>`).

3. **Client Access**: Configure a WireGuard client (e.g., on your phone or laptop) to connect to the VPS and access your home network:

```bash
[Interface]
PrivateKey = <CLIENT_PRIVATE_KEY>
Address = 10.0.0.3/24
DNS = 1.1.1.1

[Peer]
PublicKey = <VPS_PUBLIC_KEY>
Endpoint = <VPS_PUBLIC_IP>:51820
AllowedIPs = 10.0.0.0/24, 192.168.1.0/24
PersistentKeepalive = 25
```

Generate a new key pair for the client and add its public key to the VPS’s `wg0.conf` under a new `[Peer]` section.

---

### Troubleshooting
- **No Handshake**: Check firewall settings, ensure the VPS’s public IP and port are correct, and verify `PersistentKeepalive` is set.
- **No Traffic**: Confirm IP forwarding is enabled (`sysctl net.ipv4.ip_forward=1`) and iptables rules are correct.
- **Can’t Access Services**: Ensure the correct ports are forwarded and the home server’s firewall allows incoming traffic.
- **Routing Issues**: If you can’t access the home LAN, ensure the `AllowedIPs` includes the LAN subnet (`192.168.1.0/24`) and check for conflicting IP ranges.

---

### Notes
- **Security**: Use strong private keys and restrict `AllowedIPs` to minimize exposure. Consider a firewall like `ufw` or `firewalld` for additional security.
- **Performance**: Choose a VPS geographically close to reduce latency.
- **Alternatives**: Tools like Tailscale or ZeroTier can simplify CGNAT traversal but may rely on relay servers, potentially reducing speed compared to WireGuard.

This setup creates a reliable tunnel to bypass CGNAT, allowing access to your home network services via the VPS’s public IP.[](https://gtello.github.io/posts/exposing-server-behind-cgnat/)
