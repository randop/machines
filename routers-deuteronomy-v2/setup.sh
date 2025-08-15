#!/bin/bash
set -euo pipefail

pacman -S powerdns dnsmasq dnsdist openbsd-netcat

# powerdns setup
mariadb -u pdns -p pdns </usr/share/doc/powerdns/schema.mysql.sql
