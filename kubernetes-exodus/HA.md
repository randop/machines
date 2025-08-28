# Kubernetes High Availability

### Prerequisites
- All three nodes are running Arch Linux and can communicate with each other on the 10.0.0.0/8 network.
- Assume you have root access (or sudo) on each node.
- Identify the network interface on each node that holds the 10.0.0.x IP (e.g., `eno1`, `enp1s0`). Use `ip addr show` to check. I'll use `eno1` in examples; replace it with your actual interface.
- This setup assumes you're load balancing a simple HTTP service (e.g., Nginx web server) running on each node at port 80. The HAProxy frontend will use the VIP 10.0.0.10:80 to avoid port conflicts.
- The setup provides high availability for HAProxy via failover (active-passive), not active-active load balancing of the load balancers themselves. Keepalived manages the VIP, assigning it to one "master" node at a time. If the master fails, a backup takes over.
- Backends are the three nodes themselves (self-load-balancing), which is unusual but possible. Traffic to 10.0.0.10:80 will be distributed round-robin to 10.0.0.1:80, 10.0.0.2:80, and 10.0.0.3:80.
- To test, clients should send requests to 10.0.0.10:80 (e.g., `curl 10.0.0.10`).

### Step 1: Install Required Packages on All Nodes
Run these commands on each node (10.0.0.1, 10.0.0.2, 10.0.0.3):

```
pacman -Syu --noconfirm haproxy keepalived nginx
```

- HAProxy: The load balancer.
- Keepalived: Manages the VIP and failover.
- Nginx: Example backend service (replace with your actual service if different).

### Step 2: Configure the Backend Service (Nginx) on Each Node
Nginx will serve as the backend HTTP service. Configure it to bind **only** to the node's specific IP on port 80 (not 0.0.0.0) to avoid conflicts with HAProxy.

1. On each node, edit `/etc/nginx/nginx.conf` (or create `/etc/nginx/sites-enabled/default` if using sites-enabled):
   ```
   nano /etc/nginx/nginx.conf
   ```

2. Replace the `http { ... }` block with this (adjust the `listen` IP for each node):
   - On 10.0.0.1:
     ```
     http {
         upstream backend { }  # Not needed, but placeholder if extending
         server {
             listen 10.0.0.1:80;
             server_name node1;
             location / {
                 root /usr/share/nginx/html;
                 index index.html;
             }
         }
     }
     ```
   - On 10.0.0.2: Change `listen 10.0.0.2:80;` and `server_name node2;`.
   - On 10.0.0.3: Change `listen 10.0.0.3:80;` and `server_name node3;`.

3. Create a simple test page to identify the node:
   - On 10.0.0.1: `echo "Served by Node 1 (10.0.0.1)" | tee /usr/share/nginx/html/index.html`
   - On 10.0.0.2: `echo "Served by Node 2 (10.0.0.2)" | tee /usr/share/nginx/html/index.html`
   - On 10.0.0.3: `echo "Served by Node 3 (10.0.0.3)" | tee /usr/share/nginx/html/index.html`

4. Test and start Nginx:
   ```
   nginx -t
   systemctl enable --now nginx
   ```

   Verify: `curl 10.0.0.1` on node1 should show "Served by Node 1...". Repeat for others.

### Step 3: Configure HAProxy on All Nodes
The HAProxy config is identical on all nodes. It binds specifically to the VIP (10.0.0.10:80) and load balances to the three nodes as backends.

1. Edit `/etc/haproxy/haproxy.cfg`:
   ```
   nano /etc/haproxy/haproxy.cfg
   ```

2. Replace the entire file with:
   ```
   global
       log /dev/log local0
       log /dev/log local1 notice
       chroot /var/lib/haproxy
       stats socket /run/haproxy/admin.sock mode 660 level admin
       stats timeout 30s
       user haproxy
       group haproxy
       daemon

   defaults
       log global
       mode http
       option httplog
       option dontlognull
       timeout connect 5000
       timeout client 50000
       timeout server 50000

   frontend http_front
       bind 10.0.0.10:80
       default_backend http_back

   backend http_back
       balance roundrobin
       server node1 10.0.0.1:80 check
       server node2 10.0.0.2:80 check
       server node3 10.0.0.3:80 check
   ```

3. Test the config (it may warn about the bind if VIP isn't assigned yet; that's okay for now):
   ```
   haproxy -f /etc/haproxy/haproxy.cfg -c
   ```

   **Note:** Do **not** start HAProxy yet. Keepalived will handle starting/stopping it based on master/backup state.

### Step 4: Configure Keepalived on Each Node
Keepalived manages the VIP and runs scripts to start/stop HAProxy. Configs differ slightly by node (priority and state).

1. On all nodes, edit `/etc/keepalived/keepalived.conf`:
   ```
   nano /etc/keepalived/keepalived.conf
   ```

2. Use these configs (replace `eno1` with your interface; use the same `auth_pass` on all nodes, e.g., a strong password):
   - On 10.0.0.1 (highest priority, initial master):
     ```
     vrrp_script chk_haproxy {
         script "killall -0 haproxy"
         interval 2
         weight 2
     }

     vrrp_instance VI_1 {
         state MASTER
         interface eno1
         virtual_router_id 51
         priority 150
         advert_int 1
         authentication {
             auth_type PASS
             auth_pass yourstrongpassword
         }
         virtual_ipaddress {
             10.0.0.10/8
         }
         track_script {
             chk_haproxy
         }
         notify_master "/bin/systemctl start haproxy"
         notify_backup "/bin/systemctl stop haproxy"
         notify_fault "/bin/systemctl stop haproxy"
     }
     ```
   - On 10.0.0.2:
     ```
     vrrp_script chk_haproxy {
         script "killall -0 haproxy"
         interval 2
         weight 2
     }

     vrrp_instance VI_1 {
         state BACKUP
         interface eno1
         virtual_router_id 51
         priority 100
         advert_int 1
         authentication {
             auth_type PASS
             auth_pass yourstrongpassword
         }
         virtual_ipaddress {
             10.0.0.10/8
         }
         track_script {
             chk_haproxy
         }
         notify_master "/bin/systemctl start haproxy"
         notify_backup "/bin/systemctl stop haproxy"
         notify_fault "/bin/systemctl stop haproxy"
     }
     ```
   - On 10.0.0.3:
     Similar to node2, but `priority 50`.

3. Start and enable Keepalived on all nodes:
   ```
   systemctl enable --now keepalived
   ```

### Step 5: Verify the Setup
1. On the initial master (10.0.0.1), check VIP assignment: `ip addr show eno1` should show 10.0.0.10.
2. Check HAProxy status: `systemctl status haproxy` (should be running on master, stopped on backups).
3. Test load balancing: From any machine on the network, run `curl 10.0.0.10` multiple times. It should round-robin between "Served by Node X".
4. Test failover: Stop Keepalived on the master (`systemctl stop keepalived`). The VIP should move to the next highest priority node (e.g., 10.0.0.2). Check with `ip addr` and repeat curls.
5. Logs: Check `/var/log/messages` or `journalctl -u keepalived` for VRRP transitions; `journalctl -u haproxy` for HAProxy.

### Troubleshooting
- If HAProxy fails to start: Ensure the VIP is assigned (`ip addr`) and no port conflicts (Nginx binds to node IP only).
- Firewall: If using firewalld or ufw, allow port 80 and VRRP (multicast port 112).
- No VIP on master: Check Keepalived logs for auth mismatches or interface errors.
- Customization: Adjust timeouts, health checks, or add SSL in HAProxy config as needed. If your backend service isn't HTTP or on port 80, update ports accordingly (e.g., backend servers on :8080).
- For production: Use a more secure auth_pass, monitor with tools like Prometheus, and test failovers thoroughly.

This setup ensures the VIP floats between nodes for HA, with HAProxy load balancing traffic to all three nodes as backends. If your service differs (e.g., no Nginx), adapt Step 2 accordingly.
