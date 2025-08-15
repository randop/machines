#!/bin/bash
set -euo pipefail

pacman -S powerdns dnsmasq

# powerdns setup
mariadb -u pdns -p pdns </usr/share/doc/powerdns/schema.mysql.sql
