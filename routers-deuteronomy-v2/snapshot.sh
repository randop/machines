#!/usr/bin/env bash

#  Copyright © 2010 — 2026 Randolph Ledesma
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

# Get Arch Linux information
uname -a
# Linux markpeter 6.18.60-1-lts #1 SMP PREEMPT_DYNAMIC Fri, 30 Oct 2026 12:43:14 +0000 x86_64 GNU/Linux

hostnamectl
#  Static hostname: markpeter
#        Icon name: computer-desktop
#          Chassis: desktop 🖥
#       Machine ID: 00000000000000000000000000000000
#          Boot ID: 67f947bb59db44498a8d2762f039bd08
#     Product UUID: 00000000-0000-0000-0000-000000080000
# Operating System: Arch Linux
#           Kernel: Linux 6.18.60-1-lts
#     Architecture: x86-64
#  Hardware Vendor: AMI Corporation
#   Hardware Model: Aptio CRB
#  Hardware Serial: Default string
# Firmware Version: 5.6.5
#    Firmware Date: Mon 2999-01-01
#     Firmware Age: 0y 0month 0w 0d

mariadb -e "SELECT VERSION();"
# +----------------+
# | VERSION()      |
# +----------------+
# | 13.0.2-MariaDB |
# +----------------+

dnsmasq --version
# Dnsmasq version 2.93  Copyright (c) 2000-2026 Simon Kelley
# Compile time options: IPv6 GNU-getopt DBus no-UBus i18n IDN2 DHCP DHCPv6 no-Lua TFTP conntrack ipset nftset auth DNSSEC loop-detect inotify dumpfile

pdns_server --version
# Nov 02 17:03:21 Loading '/usr/lib/powerdns/libremotebackend.so'
# Nov 02 17:03:21 Loading '/usr/lib/powerdns/libpipebackend.so'
# Nov 02 17:03:21 Loading '/usr/lib/powerdns/libldapbackend.so'
# Nov 02 17:03:21 Loading '/usr/lib/powerdns/libgpgsqlbackend.so'
# Nov 02 17:03:21 Loading '/usr/lib/powerdns/liblmdbbackend.so'
# Nov 02 17:03:21 Loading '/usr/lib/powerdns/libgeoipbackend.so'
# Nov 02 17:03:21 Unable to load module '/usr/lib/powerdns/libgeoipbackend.so': libyaml-cpp.so.0.9: cannot open shared object file: No such file or directory
# Nov 02 17:03:21 DNSBackend unable to load module in libgeoipbackend.so
# PowerDNS Authoritative Server 5.1.5 (C) PowerDNS.COM BV
# Using 64-bits mode. Built using gcc 16.2.1 20260810.
# PowerDNS comes with ABSOLUTELY NO WARRANTY. This is free software, and you are welcome to redistribute it according to the terms of the GPL version 2.

kea-dhcp4 -V
# 3.2.1-git (git 1737462bc79276e3269304ea8cd3d1c03400e30d)
# premium: no
# linked with:
# - log4cplus 2.2.0
# - OpenSSL 3.6.5 29 Sep 2026
# lease backends:
# - Memfile backend 3.0

dnsdist -V
# dnsdist 2.1.3 (Lua 5.1.4 [LuaJIT 2.1.1788856981])
# Enabled features: AF_XDP cdb dns-over-quic dns-over-http3 dns-over-tls(gnutls openssl) dns-over-https(nghttp2) dnscrypt ebpf fstrm ipcipher ipcrypt2 libedit libsodium lmdb protobuf re2 recvmmsg/sendmmsg snmp systemd yaml

iperf3 --version
# iperf 3.22 (cJSON 1.7.15)
# Optional features available: CPU affinity setting, IPv6 flow label, SCTP, TCP congestion algorithm setting, sendfile / zerocopy, socket pacing, authentication, bind to device, support IPv4 don't fragment, POSIX threads, GSO/GRO support

df -h
# Filesystem      Size  Used Avail Use% Mounted on
# /dev/sda2       117G   59G   52G  54% /
# devtmpfs        1.9G     0  1.9G   0% /dev
# tmpfs           1.9G     0  1.9G   0% /dev/shm
# efivarfs        128K   51K   73K  41% /sys/firmware/efi/efivars
# tmpfs           760M 1000K  759M   1% /run
# tmpfs           1.9G  376K  1.9G   1% /tmp
# none            1.0M     0  1.0M   0% /run/credentials/systemd-journald.service
# /dev/loop0      3.8G  3.8G     0 100% /srv/ipxe.tindango/os-images/debian-13-dvd1
# /dev/sda1       511M   69M  443M  14% /boot
# none            1.0M     0  1.0M   0% /run/credentials/getty@tty1.service
# tmpfs           380M  8.0K  380M   1% /run/user/1001
# tmpfs           380M  4.0K  380M   1% /run/user/963
# tmpfs           380M  4.0K  380M   1% /run/user/1000

fdisk -l
# Disk /dev/sda: 119.24 GiB, 128035676160 bytes, 250069680 sectors
# Disk model: ORICO
# Units: sectors of 1 * 512 = 512 bytes
# Sector size (logical/physical): 512 bytes / 512 bytes
# I/O size (minimum/optimal): 512 bytes / 512 bytes
# Disklabel type: gpt
# Disk identifier: 00000000-0000-0000-0000-000000000000
#
# Device       Start       End   Sectors   Size Type
# /dev/sda1     2048   1050623   1048576   512M EFI System
# /dev/sda2  1050624 250068991 249018368 118.7G Linux filesystem

pacman -Qi refind
# Name            : refind
# Version         : 0.14.2-3
# Description     : An EFI boot manager
# Architecture    : x86_64
# URL             : https://www.rodsbooks.com/refind/
# Licenses        : BSD-2-Clause  CC-BY-SA-3.0  CC-BY-SA-4.0  GPL-2.0-only  GPL-2.0-or-later  GPL-3.0-or-later  LGPL-2.1-or-later
#                   LGPL-3.0-or-later OR CC-BY-SA-3.0
# Groups          : None
# Provides        : None
# Depends On      : bash  dosfstools  efibootmgr
# Optional Deps   : gptfdisk: for finding non-vfat ESP with refind-install
#                   imagemagick: for refind-mkfont
#                   openssl: for generating local certificates with refind-install [installed]
#                   python: for refind-mkdefault [installed]
#                   refind-docs: for HTML documentation
#                   sbsigntools: for EFI binary signing with refind-install
#                   sudo: for privilege elevation in refind-install and refind-mkdefault
# Required By     : None
# Optional For    : None
# Conflicts With  : None
# Replaces        : None
# Installed Size  : 1930.69 KiB
# Packager        : Campbell Jones <serebit@archlinux.org>
# Build Date      : Wed 29 Apr 2026 04:14:23 AM UTC
# Install Date    : Sat 29 Aug 2026 05:47:44 AM UTC
# Install Reason  : Explicitly installed
# Install Script  : No
# Validated By    : Signature

ufw --version
# ufw 0.36.2
# Copyright 2008-2023 Canonical Ltd.

NetworkManager -V
# 1.58.1-2

bird --version
# BIRD version 3.4.0

hostapd -v
# hostapd v2.12-hostap_2_12+
# User space daemon for IEEE 802.11 AP management,
# IEEE 802.1X/WPA/WPA2/EAP/RADIUS Authenticator
# Copyright (c) 2002-2026, Jouni Malinen <j@w1.fi> and contributors

sqlite3 --version
# 3.54.1 2026-10-16 14:45:20 555e07ef33f69a0957d24d8e555b702464a131d6f1607f4c3c1e4551e8e6alt1 (64-bit)

pacman -Qi reflector
# Name            : reflector
# Version         : 2023-5
# Description     : A Python 3 module and script to retrieve and filter the latest Pacman mirror list.
# Architecture    : any
# URL             : https://xyne.dev/projects/reflector
# Licenses        : GPL-2.0-only
# Groups          : None
# Provides        : None
# Depends On      : python
# Optional Deps   : rsync: rate rsync mirrors
# Required By     : None
# Optional For    : None
# Conflicts With  : None
# Replaces        : None
# Installed Size  : 158.15 KiB
# Packager        : Bert Peters <bertptrs@archlinux.org>
# Build Date      : Sun 18 Jan 2026 04:35:51 PM UTC
# Install Date    : Mon 16 Mar 2026 04:33:13 PM UTC
# Install Reason  : Explicitly installed
# Install Script  : No
# Validated By    : Signature

pacman -Qi intel-ucode
# Name            : intel-ucode
# Version         : 20260925-1
# Description     : Microcode update files for Intel CPUs
# Architecture    : any
# URL             : https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files
# Licenses        : custom
# Groups          : None
# Provides        : None
# Depends On      : None
# Optional Deps   : None
# Required By     : None
# Optional For    : None
# Conflicts With  : None
# Replaces        : microcode_ctl
# Installed Size  : 31.45 MiB
# Packager        : T.J. Townsend <blakkheim@archlinux.org>
# Build Date      : Fri 25 Sep 2026 10:53:29 PM UTC
# Install Date    : Wed 07 Oct 2026 06:58:50 AM UTC
# Install Reason  : Explicitly installed
# Install Script  : No
# Validated By    : Signature

journalctl -k --grep=microcode
# Sep 25 06:51:39 archlinux kernel: microcode: Current revision: 0x0000090d
# Sep 25 06:51:39 archlinux kernel: microcode: Updated early from: 0x0000090a

vnstat --version
# vnStat 2.14 by Teemu Toivola <tst at iki dot fi> (SQLite 3.54.1)

haproxy -v
# HAProxy version 3.4.7 2026/10/14 - https://haproxy.org/
# Status: long-term supported branch - will stop receiving fixes around Q2 2031.
# Known bugs: http://www.haproxy.org/bugs/bugs-3.4.7.html
# Running on: Linux 6.18.60-1-lts #1 SMP PREEMPT_DYNAMIC Fri, 30 Oct 2026 12:43:14 +0000 x86_64

nginx -V
# nginx version: nginx/1.30.6
# built by gcc 16.2.1 20260810 (GCC)
# built with OpenSSL 3.6.5 29 Sep 2026
# TLS SNI support enabled
# configure arguments: --prefix=/etc/nginx --conf-path=/etc/nginx/nginx.conf --sbin-path=/usr/bin/nginx --modules-path=/usr/lib/nginx/modules --pid-path=/run/nginx.pid --lock-path=/run/lock/nginx.lock --user=http --group=http --http-log-path=/var/log/nginx/access.log --error-log-path=stderr --http-client-body-temp-path=/var/lib/nginx/client-body --http-proxy-temp-path=/var/lib/nginx/proxy --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-cc-opt='-march=x86-64 -mtune=generic -O2 -pipe -fno-plt -fexceptions -Wp,-D_FORTIFY_SOURCE=3 -Wformat -Werror=format-security -fstack-clash-protection -fcf-protection -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer -g -ffile-prefix-map=/build/nginx/src=/usr/src/debug/nginx -flto=auto' --with-ld-opt='-Wl,-O1 -Wl,--sort-common -Wl,--as-needed -Wl,-z,relro -Wl,-z,now -Wl,-z,pack-relative-relocs -flto=auto' --with-compat --with-debug --with-file-aio --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_degradation_module --with-http_flv_module --with-http_geoip_module=dynamic --with-http_gunzip_module --with-http_gzip_static_module --with-http_image_filter_module=dynamic --with-http_mp4_module --with-http_perl_module=dynamic --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-http_v3_module --with-http_xslt_module=dynamic --with-mail=dynamic --with-mail_ssl_module --with-pcre-jit --with-stream=dynamic --with-stream_geoip_module=dynamic --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-threads
