# PowerDNS Setup with MariaDB on Arch Linux Router

This guide sets up PowerDNS (authoritative and recursor) on an Arch Linux router to serve DNS for a 10.0.0.0/8 network, using MariaDB as the backend. It integrates with Kubernetes and Calico to dynamically update DNS records for LoadBalancer service IPs.

## Prerequisites
- Arch Linux router with IP 10.0.0.1 on network 10.0.0.0/8.
- Kubernetes cluster with Calico CNI, using MetalLB or similar for LoadBalancer IPs in 10.0.0.0/8.
- Administrative access to install packages and configure services.

## Step 1: Install PowerDNS and MariaDB
1. Update system and install packages:
   ```bash
   sudo pacman -Syu powerdns powerdns-recursor mariadb
   ```

2. Initialize MariaDB:
   ```bash
   sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
   sudo systemctl enable --now mariadb
   ```

3. Secure MariaDB installation:
   ```bash
   sudo mariadb-secure-installation
   ```
   - Set root password, remove anonymous users, disallow remote root login, and remove test database.

4. Create PowerDNS database and user:
   ```bash
   sudo mariadb -u root -p
   ```
   ```sql
   CREATE DATABASE pdns;
   GRANT ALL PRIVILEGES ON pdns.* TO 'pdns'@'localhost' IDENTIFIED BY 'your_secure_password';
   FLUSH PRIVILEGES;
   EXIT;
   ```

## Step 2: Configure MariaDB for PowerDNS
1. Initialize the PowerDNS schema:
   ```bash
   sudo mariadb -u pdns -p pdns < /usr/share/doc/pdns/schema.mariadb.sql
   ```
   - This creates tables for zones, records, etc. Verify with `sudo mariadb -u pdns -p pdns -e "SHOW TABLES;"`.

## Step 3: Configure PowerDNS Authoritative Server
1. Edit `/etc/powerdns/pdns.conf`:
   ```ini
   launch=gmysql
   gmysql-host=localhost
   gmysql-port=3306
   gmysql-dbname=pdns
   gmysql-user=pdns
   gmysql-password=your_secure_password
   api=yes
   api-key=your-secret-api-key-12345  # Replace with a secure key
   webserver=yes
   webserver-address=127.0.0.1
   webserver-port=8081
   master=yes
   allow-axfr-ips=10.0.0.0/8  # Allow zone transfers within network
   allow-dnsupdate-from=10.0.0.0/8  # Allow dynamic updates
   ```
   - The `gmysql` backend uses MariaDB. The API enables ExternalDNS integration.

2. Create a DNS zone:
   ```bash
   pdnsutil create-zone internal.tindango
   pdnsutil add-record internal.tindango @ NS ns1.internal.tindango
   pdnsutil add-record internal.tindango ns1 A 10.0.0.1
   pdnsutil create-zone blocked.domains
   pdnsutil add-record blocked.domains @ NS ns1.blocked.domains
   pdnsutil add-record blocked.domains ns1 A 10.0.0.1

   ```

3. Enable and start PowerDNS:
   ```bash
   sudo systemctl enable --now pdns
   ```

## Step 4: Configure PowerDNS Recursor
1. Edit `/etc/powerdns/recursor.conf` for caching/forwarding:
   ```ini
   forward-zones-recurse=.=8.8.8.8;8.8.4.4  # Forward to Google DNS
   local-address=10.0.0.1  # Router's IP
   allow-from=10.0.0.0/8  # Restrict to your network
   ```

2. Enable and start recursor:
   ```bash
   sudo systemctl enable --now pdns-recursor
   ```

3. Update router’s DHCP (if using Kea or another DHCP server) to advertise 10.0.0.1 as the DNS server.

## Step 5: Integrate with Kubernetes and Calico
1. **Configure Calico IPAM**:
   - Ensure Calico uses 10.0.0.0/8 for pod/service IPs:
     ```bash
     calicoctl apply -f - <<EOF
     apiVersion: projectcalico.org/v3
     kind: IPPool
     metadata:
       name: default-ipv4-ippool
     spec:
       cidr: 10.0.0.0/8
       ipipMode: Never
       natOutgoing: true
     EOF
     ```

2. **Deploy ExternalDNS**:
   - Install via Helm in your Kubernetes cluster:
     ```bash
     helm repo add bitnami https://charts.bitnami.com/bitnami
     helm install external-dns bitnami/external-dns --namespace external-dns --create-namespace \
       --set provider=pdns \
       --set pdns.apiUrl=http://10.0.0.1:8081 \
       --set pdns.apiKey=your-secret-api-key-12345 \
       --set domainFilters={internal.mynetwork}
     ```

3. **Create a Test LoadBalancer Service**:
   ```yaml
   apiVersion: v1
   kind: Service
   metadata:
     name: test-service
     namespace: default
     annotations:
       external-dns.alpha.kubernetes.io/hostname: test.internal.mynetwork
   spec:
     selector:
       app: test
     ports:
     - protocol: TCP
       port: 80
       targetPort: 8080
     type: LoadBalancer
   ```

4. **Verify DNS Updates**:
   - Check PowerDNS records:
     ```bash
     sudo pdnsutil list-zone internal.mynetwork
     ```
   - Query from a network client:
     ```bash
     dig test.internal.mynetwork @10.0.0.1
     ```

## Step 6: Test and Monitor
- Confirm services are running: `sudo systemctl status pdns pdns-recursor mariadb`.
- Monitor PowerDNS logs: `journalctl -u pdns`.
- Test resolution from a client on 10.0.0.0/8: `nslookup test.internal.mynetwork 10.0.0.1`.
- Ensure ExternalDNS logs in Kubernetes show successful updates: `kubectl logs -n external-dns -l app.kubernetes.io/name=external-dns`.

## Notes
- **Security**: Restrict API access (`api-key`) and MariaDB to localhost or trusted IPs. Use a firewall (e.g., `ufw`) to limit port 53 (DNS) and 8081 (API) to 10.0.0.0/8.
- **Calico**: Works seamlessly as it handles routing/IPAM. If using MetalLB, configure it to allocate LoadBalancer IPs from 10.0.0.0/8.
- **DNSSEC**: Enable with `pdnsutil secure-zone internal.mynetwork` for added security.
- **Alternative**: If API integration is overkill, use RFC2136 with TSIG for ExternalDNS (configure in `pdns.conf` with `allow-dnsupdate-from` and a TSIG key).
