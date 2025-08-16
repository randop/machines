#!/bin/bash
set -euo pipefail

pacman -S powerdns dnsmasq dnsdist openbsd-netcat mariadb

# mariadb setup
mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
mkdir -p /var/log/mariadb
chown mysql:mysql /var/log/mariadb
chmod 750 /var/log/mariadb
systemctl enable --now mariadb
mariadb-tzinfo-to-sql /usr/share/zoneinfo | mariadb -u root -p mysql
mariadb-check mysql

# powerdns setup
mariadb -u pdns -p pdns </usr/share/doc/powerdns/schema.mysql.sql

# enable services
systemctl enable --now dnsmasq pdns dnsdist
