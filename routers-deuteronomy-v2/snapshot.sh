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

# Get Arch Linux information
uname -a
# Linux markpeter 6.16.0-arch2-1 #1 SMP PREEMPT_DYNAMIC Wed, 13 Aug 2025 23:38:48 +0000 x86_64 GNU/Linux

hostnamectl
#  Static hostname: markpeter
#        Icon name: computer-desktop
#          Chassis: desktop 🖥
#       Machine ID: 00000000000000000000000000000000
#          Boot ID: c0a627b3167d476ca678639a411b4c7a
#     Product UUID: 00000000-0000-0000-0000-000000080000
# Operating System: Arch Linux
#           Kernel: Linux 6.16.0-arch2-1
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
# | 12.0.2-MariaDB |
# +----------------+

dnsmasq --version
# Dnsmasq version 2.91  Copyright (c) 2000-2025 Simon Kelley
# Compile time options: IPv6 GNU-getopt DBus no-UBus i18n IDN2 DHCP DHCPv6 no-Lua TFTP conntrack ipset nftset auth DNSSEC loop-detect inotify dumpfile

pdns_server --version
# Aug 16 09:58:53 PowerDNS Authoritative Server 4.9.7 (C) PowerDNS.COM BV
# Aug 16 09:58:53 Using 64-bits mode. Built using gcc 15.1.1 20250425.
# Aug 16 09:58:53 PowerDNS comes with ABSOLUTELY NO WARRANTY. This is free software, and you are welcome to redistribute it according to the terms of the GPL version 2.
# Aug 16 09:58:53 Features: libcrypto-ecdsa libcrypto-ed25519 libcrypto-ed448 libcrypto-eddsa libgeoip libmaxminddb lua lua-records protobuf sodium curl DoT scrypt
# Aug 16 09:58:53 Built-in modules:
# Aug 16 09:58:53 Loading '/usr/lib/powerdns/libremotebackend.so'
# Aug 16 09:58:53 Loading '/usr/lib/powerdns/libpipebackend.so'
# Aug 16 09:58:53 Loading '/usr/lib/powerdns/libldapbackend.so'
# Aug 16 09:58:53 Loading '/usr/lib/powerdns/libgpgsqlbackend.so'
# Aug 16 09:58:53 Loading '/usr/lib/powerdns/liblmdbbackend.so'
# Aug 16 09:58:53 Loading '/usr/lib/powerdns/libgeoipbackend.so'
# Aug 16 09:58:53 Unable to load module '/usr/lib/powerdns/libgeoipbackend.so': libyaml-cpp.so.0.8: cannot open shared object file: No such file or directory
# Aug 16 09:58:53 DNSBackend unable to load module in libgeoipbackend.so

kea-dhcp4 -V
# 3.0.0 (3.0.0 (tarball))
# premium: no
# linked with:
# - log4cplus 2.1.0
# - OpenSSL 3.5.2 5 Aug 2025
# lease backends:
# - Memfile backend 3.0

dnsdist -V
# dnsdist 2.0.0 (Lua 5.1.4 [LuaJIT 2.1.1748459687])
# Enabled features: AF_XDP cdb dns-over-quic dns-over-http3 dns-over-tls(gnutls openssl) dns-over-https(nghttp2) dnscrypt ebpf fstrm ipcipher libedit libsodium lmdb protobuf re2 recvmmsg/sendmmsg snmp systemd

iperf3 --version
# iperf 3.19.1 (cJSON 1.7.15)
# Linux markpeter 6.16.0-arch2-1 #1 SMP PREEMPT_DYNAMIC Wed, 13 Aug 2025 23:38:48 +0000 x86_64
# Optional features available: CPU affinity setting, IPv6 flow label, SCTP, TCP congestion algorithm setting, sendfile / zerocopy, socket pacing, authentication, bind to device, support IPv4 don't fragment, POSIX threads

df -h
# Filesystem      Size  Used Avail Use% Mounted on
# dev             1.9G     0  1.9G   0% /dev
# run             1.9G  972K  1.9G   1% /run
# efivarfs        128K   63K   61K  52% /sys/firmware/efi/efivars
# /dev/sda2       117G  2.7G  108G   3% /
# tmpfs           1.9G     0  1.9G   0% /dev/shm
# tmpfs           1.9G     0  1.9G   0% /tmp
# tmpfs           1.0M     0  1.0M   0% /run/credentials/systemd-journald.service
# /dev/sda1       511M  214M  298M  42% /boot
# tmpfs           1.0M     0  1.0M   0% /run/credentials/getty@tty1.service
# tmpfs           374M  4.0K  374M   1% /run/user/0
# tmpfs           374M  4.0K  374M   1% /run/user/1000

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
# Version         : 0.14.2-1
# Description     : An EFI boot manager
# Architecture    : x86_64
# URL             : https://www.rodsbooks.com/refind/
# Licenses        : BSD-2-Clause  CC-BY-SA-3.0  CC-BY-SA-4.0  GPL-2.0-only  GPL-2.0-or-later  GPL-3.0-or-later  LGPL-2.1-or-later  LGPL-3.0-or-later OR CC-BY-SA-3.0
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
# Installed Size  : 1890.15 KiB
# Packager        : David Runge <dvzrv@archlinux.org>
# Build Date      : Sun 07 Apr 2024 08:13:16 AM UTC
# Install Date    : Thu 14 Aug 2025 01:29:19 PM UTC
# Install Reason  : Explicitly installed
# Install Script  : No
# Validated By    : Signature

ufw --version
# ufw 0.36.2
# Copyright 2008-2023 Canonical Ltd.

NetworkManager -V
# 1.54.0-1
