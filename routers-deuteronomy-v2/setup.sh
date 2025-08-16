#!/bin/bash
set -euo pipefail

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

# :: MariaDB was updated to a new feature release. To update the data run:
# systemctl restart mariadb.service && mariadb-upgrade -u root -p

# powerdns setup
mariadb -u pdns -p pdns </usr/share/doc/powerdns/schema.mysql.sql

# enable services
systemctl enable --now dnsmasq pdns dnsdist
