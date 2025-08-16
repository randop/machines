#!/usr/bin/env bash

#  Copyright © 2010 — 2025 Randolph Ledesma
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -euo pipefail

# Install network manager
pacman -S networkmanager
systemctl enable --now NetworkManager
nmcli con add type bond con-name bond0 ifname bond0 mode balance-alb
nmcli con add type ethernet con-name bond0-enp1s0 ifname enp1s0 master bond0
nmcli con add type ethernet con-name bond0-enp3s0 ifname enp3s0 master bond0
nmcli con mod bond0 ipv4.addresses 10.0.0.1/8
nmcli con mod bond0 ipv4.method manual
nmcli con up bond0
nmcli con mod bond0 bond.options "mode=balance-alb,miimon=100"
nmcli con add type ethernet con-name enxe0 ifname enxe0 ipv4.method auto
systemctl restart NetworkManager

# Install dhcp dns packages
pacman -S powerdns dnsmasq dnsdist openbsd-netcat mariadb kea

# dnsmasq setup
mkdir -p /etc/dnsmasq.d/enabled
mkdir -p /etc/dnsmasq.d/available

# mariadb setup
mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
mkdir -p /var/log/mariadb
chown mysql:mysql /var/log/mariadb
chmod 750 /var/log/mariadb
systemctl enable --now mariadb
mariadb-tzinfo-to-sql /usr/share/zoneinfo | mariadb -u root -p mysql
mariadb-check mysql

# USECASE: System upgrade
# :: MariaDB was updated to a new feature release. To update the data run:
# systemctl restart mariadb.service && mariadb-upgrade -u root -p

# powerdns setup
mariadb -u pdns -p pdns </usr/share/doc/powerdns/schema.mysql.sql

# enable services
systemctl enable --now mariadb dnsmasq pdns dnsdist kea-dhcp4

# setup firewall
pacman -S ufw
systemctl enable --now ufw
ufw enable
ufw status verbose
