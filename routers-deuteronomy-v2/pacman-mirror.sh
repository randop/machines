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

reflector \ 
--verbose \
  --latest 50 \
  --age 24 \
  --protocol https \
  --sort rate \
  --fastest 15 \
  --country 'Singapore,Thailand,Indonesia,Malaysia,Vietnam,Hong Kong,Taiwan,Japan' \
  --save /etc/pacman.d/mirrorlist

# [2026-03-16 16:34:57] INFO: rating 33 mirror(s) by download speed
# [2026-03-16 16:34:57] INFO: Server                                                          Rate       Time
# [2026-03-16 16:35:00] INFO: https://singapore.mirror.pkgbuild.com/                 3557.11 KiB/s     2.30 s
# [2026-03-16 16:35:03] INFO: https://taipei.mirror.pkgbuild.com/                    8789.38 KiB/s     0.93 s
# [2026-03-16 16:35:04] INFO: https://sg.arch.niranjan.co/                           7650.10 KiB/s     1.07 s
# [2026-03-16 16:35:06] INFO: https://jp.mirrors.cicku.me/archlinux/                12404.19 KiB/s     0.66 s
# [2026-03-16 16:35:07] INFO: https://tw.mirrors.cicku.me/archlinux/                 8572.58 KiB/s     0.95 s
# [2026-03-16 16:35:09] INFO: https://mirror.twds.com.tw/archlinux/                  6872.11 KiB/s     1.19 s
# [2026-03-16 16:35:11] INFO: https://mirror.mrleong.net/archlinux/                  7200.83 KiB/s     1.14 s
# [2026-03-16 16:35:13] INFO: https://archlinux.ccns.ncku.edu.tw/archlinux/          8255.31 KiB/s     0.99 s
# [2026-03-16 16:35:20] WARNING: failed to rate http(s) download (https://mirror.guillaumea.fr/archlinux/extra/os/x86_64/extra.db): Download timed out after 5 second(s).
# [2026-03-16 16:35:20] INFO: https://mirror.guillaumea.fr/archlinux/                   0.00 KiB/s     0.00 s
# [2026-03-16 16:35:21] INFO: https://hk.mirrors.cicku.me/archlinux/                21664.62 KiB/s     0.38 s
# [2026-03-16 16:35:22] INFO: https://sg.mirrors.cicku.me/archlinux/                14325.31 KiB/s     0.57 s
# [2026-03-16 16:35:24] INFO: https://ftp.yz.yamagata-u.ac.jp/pub/linux/archlinux/   4930.81 KiB/s     1.66 s
# [2026-03-16 16:35:26] INFO: https://mirror.sg.cdn-perfprod.com/archlinux/         14307.15 KiB/s     0.57 s
# [2026-03-16 16:35:27] INFO: https://www.miraa.jp/archlinux/                        9727.74 KiB/s     0.84 s
# [2026-03-16 16:35:29] INFO: https://mirror.meowsmp.net/arch/                       8674.92 KiB/s     0.94 s
# [2026-03-16 16:35:31] INFO: https://mirror.jingk.ai/archlinux/                     4955.30 KiB/s     1.65 s
# [2026-03-16 16:35:39] INFO: https://mirror.archlinux.tw/ArchLinux/                 3729.63 KiB/s     2.19 s
# [2026-03-16 16:35:44] INFO: https://mirrors.huongnguyen.dev/arch/                  2305.87 KiB/s     3.54 s
# [2026-03-16 16:35:45] INFO: https://mirror.freedif.org/archlinux/                 15119.37 KiB/s     0.54 s
# [2026-03-16 16:35:47] INFO: https://mirror.kku.ac.th/archlinux/                   10066.96 KiB/s     0.81 s
# [2026-03-16 16:35:49] INFO: https://mirrors.nguyenhoang.cloud/archlinux/           5672.58 KiB/s     1.44 s
# [2026-03-16 16:35:51] INFO: https://mirror.ditatompel.com/archlinux/               6384.98 KiB/s     1.28 s
# [2026-03-16 16:35:58] WARNING: failed to rate http(s) download (https://mirror.gi.co.id/archlinux/extra/os/x86_64/extra.db): Download timed out after 5 second(s).
# [2026-03-16 16:35:58] INFO: https://mirror.gi.co.id/archlinux/                        0.00 KiB/s     0.00 s
# [2026-03-16 16:36:02] INFO: https://mirror.papua.go.id/archlinux/                  2912.11 KiB/s     2.80 s
# [2026-03-16 16:36:03] INFO: https://mirrors.cat.net/archlinux/                    11380.05 KiB/s     0.72 s
# [2026-03-16 16:36:06] INFO: https://archlinux.cs.nycu.edu.tw/                      4951.45 KiB/s     1.65 s
# [2026-03-16 16:36:07] INFO: https://mirror.rain.ne.jp/archlinux/                  11777.06 KiB/s     0.69 s
# [2026-03-16 16:36:09] INFO: https://mirror.aktkn.sg/archlinux/                     4464.92 KiB/s     1.83 s
# [2026-03-16 16:36:11] INFO: https://mirror-hk.koddos.net/archlinux/               10020.63 KiB/s     0.82 s
# [2026-03-16 16:36:13] INFO: https://hkg.mirror.rackspace.com/archlinux/           15064.39 KiB/s     0.54 s
# [2026-03-16 16:36:14] INFO: https://mirror.sg.gs/archlinux/                       14036.69 KiB/s     0.58 s
# [2026-03-16 16:36:15] INFO: https://kacabenggala.uny.ac.id/archlinux/              9452.86 KiB/s     0.86 s
# [2026-03-16 16:36:18] INFO: https://mirror.citrahost.com/archlinux/                4500.18 KiB/s     1.81 s

cat /etc/pacman.d/mirrorlist
################################################################################
################# Arch Linux mirrorlist generated by Reflector #################
################################################################################

# With:       reflector --verbose --latest 50 --age 24 --protocol https --sort rate --fastest 15 --country 'Singapore,Thailand,Indonesia,Malaysia,Vietnam,Hong Kong,Taiwan,Japan' --save /etc/pacman.d/mirrorlist
# When:       2026-03-16 16:36:18 UTC
# From:       https://archlinux.org/mirrors/status/json/
# Retrieved:  2026-03-16 16:34:56 UTC
# Last Check: 2026-03-16 15:16:05 UTC

# Server = https://hk.mirrors.cicku.me/archlinux/$repo/os/$arch
# Server = https://mirror.freedif.org/archlinux/$repo/os/$arch
# Server = https://hkg.mirror.rackspace.com/archlinux/$repo/os/$arch
# Server = https://sg.mirrors.cicku.me/archlinux/$repo/os/$arch
# Server = https://mirror.sg.cdn-perfprod.com/archlinux/$repo/os/$arch
# Server = https://mirror.sg.gs/archlinux/$repo/os/$arch
# Server = https://jp.mirrors.cicku.me/archlinux/$repo/os/$arch
# Server = https://mirror.rain.ne.jp/archlinux/$repo/os/$arch
# Server = https://mirrors.cat.net/archlinux/$repo/os/$arch
# Server = https://mirror.kku.ac.th/archlinux/$repo/os/$arch
# Server = https://mirror-hk.koddos.net/archlinux/$repo/os/$arch
# Server = https://www.miraa.jp/archlinux/$repo/os/$arch
# Server = https://kacabenggala.uny.ac.id/archlinux/$repo/os/$arch
# Server = https://taipei.mirror.pkgbuild.com/$repo/os/$arch
# Server = https://mirror.meowsmp.net/arch/$repo/os/$arch
