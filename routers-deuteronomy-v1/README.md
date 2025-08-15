# DEUTERONOMY

### DevOps

#### Internet Gateway
```bash
sudo su

# Install packages
apt install openssh-server apt-transport-https ufw dnsmasq

# Time
timedatectl set-timezone "UTC"

# Services
systemctl restart systemd-timesyncd
systemctl stop apt-daily-upgrade.timer apt-daily.timer
systemctl mask apt-daily-upgrade.timer apt-daily.timer

# Firewall
ufw allow from 192.168.6.0/24 to any port 22 proto tcp
ufw allow from 192.168.7.0/24 to any port 22 proto tcp
ufw allow dns
ufw enable
ufw status verbose
systemctl restart ufw

```
