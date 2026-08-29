# pacman

## system upgrade
```shell
pacman -Syyu
```
```
:: Synchronizing package databases...
 core                                                        127.0 KiB   164 KiB/s 00:01 [###################################################] 100%
 extra                                                         8.5 MiB  4.76 MiB/s 00:02 [###################################################] 100%
:: Starting full system upgrade...
resolving dependencies...
looking for conflicting packages...

Packages (158) abseil-cpp-20260817.0-1  acl-2.4.0-1  archlinux-keyring-20260727-1  attr-2.6.0-1  audit-4.2.1-1  bash-5.3.15-1  bind-9.20.27-1
               binutils-2.47-4  bird-3.2.1-1  boost-libs-1.92.0-1  btop-1.4.7-1  ca-certificates-mozilla-3.128-1  coreutils-9.11-2
               cryptsetup-2.8.7-1  curl-8.21.0-1  device-mapper-2.03.42-1  dnsdist-2.1.1-2  dnsmasq-2.93-1  efibootmgr-18-4  efivar-39-2
               expat-2.8.3-1  file-5.48-1  findutils-4.11.0-1  gawk-5.4.1-1  gcc-libs-16.2.1+r23+gd564253eb6c8-1  glib2-2.88.3-1
               glibc-2.44+r24+g16be1518495f-1  gnupg-2.4.9-3  gnutls-3.8.13-2  gpgme-2.1.2-1  hicolor-icon-theme-0.18-1  hostapd-2.12-1
               htop-3.5.3-1  hwdata-0.410-1  iana-etc-20260617-1  intel-ucode-20260812-1  iperf3-3.21-1  iproute2-7.2.0-1  iptables-1:1.8.13-1
               jansson-2.15.1-1  jemalloc-1:5.3.1-3  json-c-0.19-1  kbd-2.10.0-1  kea-1:3.2.0-2  keyutils-1.6.3-4  krb5-1.22.2-1
               leancrypto-1.8.0-1  libarchive-3.8.9-1  libasan-16.2.1+r23+gd564253eb6c8-1  libatomic-16.2.1+r23+gd564253eb6c8-1  libbpf-1.7.0-1
               libcap-2.78-1  libcap-ng-0.9.5-1  libdrm-2.4.134-1  libedit-20260512_3.1-1  libelf-0.196-1  libevent-2.1.13-2  libffi-3.8.0-1
               libgcc-16.2.1+r23+gd564253eb6c8-1  libgcrypt-1.12.3-1  libgfortran-16.2.1+r23+gd564253eb6c8-1  libgomp-16.2.1+r23+gd564253eb6c8-1
               libgpg-error-1.61-1  libhwasan-16.2.1+r23+gd564253eb6c8-1  libksba-1.8.1-1  liblsan-16.2.1+r23+gd564253eb6c8-1
               libmakepkg-dropins-20-2  libmd-1.2.0-1  libnetfilter_conntrack-1.1.1-1  libnghttp2-1.70.0-1  libnghttp3-1.18.0-1
               libngtcp2-1.25.0-1  libnm-1.58.1-1  libnsl-2.0.1-2  libnvme-1.16.2-2  libobjc-16.2.1+r23+gd564253eb6c8-1  libp11-kit-0.26.5-1
               libpgm-5.3.128-4  libquadmath-16.2.1+r23+gd564253eb6c8-1  libsodium-1.0.22-1  libssh-0.12.2-1  libssh2-1.11.1-7
               libstdc++-16.2.1+r23+gd564253eb6c8-1  libsysprof-capture-50.0-6  libtsan-16.2.1+r23+gd564253eb6c8-1
               libubsan-16.2.1+r23+gd564253eb6c8-1  libunistring-1.4.2-1  liburing-2.15-1  libusb-1.0.30-1  libuv-1.52.1-2  libverto-0.3.2-6
               libxdp-1.6.3-2  libxml2-2.15.3-1  linux-7.1.11.arch1-1  linux-api-headers-7.2-1  linux-firmware-20260810-2
               linux-firmware-amdgpu-20260810-2  linux-firmware-atheros-20260810-2  linux-firmware-broadcom-20260810-2
               linux-firmware-cirrus-20260810-2  linux-firmware-intel-20260810-2  linux-firmware-mediatek-20260810-2
               linux-firmware-nvidia-20260810-2  linux-firmware-other-20260810-2  linux-firmware-radeon-20260810-2
               linux-firmware-realtek-20260810-2  linux-firmware-whence-20260810-2  log4cplus-2.2.0.1-1  luajit-2.1.1787165859+1ee778a-1
               mariadb-12.3.3-2  mariadb-clients-12.3.3-2  mariadb-libs-12.3.3-2  mkinitcpio-41.1-1  mpdecimal-4.0.1-3  nano-9.2-1  ncurses-6.6-2
               nettle-4.0-1  networkmanager-1.58.1-1  nspr-4.40-1  nss-3.128-1  openbsd-netcat-1.238_1-1  openssh-10.5p1-1  openssl-3.6.4-1
               p11-kit-0.26.5-1  pacman-7.1.0.r9.g54d9411-2  pacman-mirrorlist-20260610-1  pambase-20260616-1  pciutils-3.15.0-1  pcre-8.45-5
               pcsclite-2.5.1-1  perl-5.42.2-2  pinentry-1.3.3-1  postgresql-libs-18.6-1  powerdns-5.1.4-4  procps-ng-4.0.7-1  psmisc-23.7-2
               python-3.14.7-1  quiche-0.29.3-1  re2-2:2025.11.05-6  refind-0.14.2-3  sed-4.10-2  shadow-4.20.0.arch1-1  sqlite-3.53.4-1
               strace-7.0-1  systemd-261.2-1  systemd-libs-261.2-1  systemd-sysvcompat-261.2-1  tar-1.35-5  tinycdb-0.81-2  tpm2-tss-4.2.0-2
               tzdata-2026c-1  util-linux-2.42.2-1  util-linux-libs-2.42.2-1  vim-9.2.1011-1  vim-runtime-9.2.1011-1  wget-1.25.0-6
               wpa_supplicant-2:2.12-1  xz-5.8.3-1

Total Download Size:    799.75 MiB
Total Installed Size:  1741.29 MiB
Net Upgrade Size:       162.75 MiB

:: Proceed with installation? [Y/n] 
```

## compare versions pre-upgrade
```shell
pacman -Qu
```
```
abseil-cpp 20250814.1-1 -> 20260817.0-1
acl 2.3.2-1 -> 2.4.0-1
archlinux-keyring 20260301-1 -> 20260727-1
attr 2.5.2-1 -> 2.6.0-1
audit 4.1.3-1 -> 4.2.1-1
bash 5.3.9-1 -> 5.3.15-1
bind 9.20.20-1 -> 9.20.27-1
binutils 2.46-1 -> 2.47-4
bird 3.2.0-2 -> 3.2.1-1
boost-libs 1.89.0-4 -> 1.92.0-1
btop 1.4.6-1 -> 1.4.7-1
ca-certificates-mozilla 3.121-1 -> 3.128-1
coreutils 9.10-1 -> 9.11-2
cryptsetup 2.8.4-1 -> 2.8.7-1
curl 8.19.0-1 -> 8.21.0-1
device-mapper 2.03.38-1 -> 2.03.42-1
dnsdist 2.0.3-1 -> 2.1.1-2
dnsmasq 2.92-1 -> 2.93-1
efibootmgr 18-3 -> 18-4
efivar 39-1 -> 39-2
expat 2.7.5-1 -> 2.8.3-1
file 5.47-1 -> 5.48-1
findutils 4.10.0-3 -> 4.11.0-1
gawk 5.4.0-1 -> 5.4.1-1
gcc-libs 15.2.1+r604+g0b99615a8aef-1 -> 16.2.1+r23+gd564253eb6c8-1
glib2 2.86.4-1 -> 2.88.3-1
glibc 2.43+r5+g856c426a7534-1 -> 2.44+r24+g16be1518495f-1
gnupg 2.4.9-1 -> 2.4.9-3
gnutls 3.8.12-2 -> 3.8.13-2
gpgme 2.0.1-3 -> 2.1.2-1
hostapd 2.11-4 -> 2.12-1
htop 3.4.1-1 -> 3.5.3-1
hwdata 0.405-1 -> 0.410-1
iana-etc 20260306-1 -> 20260617-1
intel-ucode 20260227-1 -> 20260812-1
iperf3 3.20-1 -> 3.21-1
iproute2 6.19.0-2 -> 7.2.0-1
iptables 1:1.8.11-2 -> 1:1.8.13-1
jansson 2.15.0-1 -> 2.15.1-1
jemalloc 1:5.3.0-7 -> 1:5.3.1-3
json-c 0.18-2 -> 0.19-1
kbd 2.9.0-1 -> 2.10.0-1
kea 1:3.0.2-3 -> 1:3.2.0-2
keyutils 1.6.3-3 -> 1.6.3-4
krb5 1.21.3-2 -> 1.22.2-1
leancrypto 1.6.0-1 -> 1.8.0-1
libarchive 3.8.6-1 -> 3.8.9-1
libasan 15.2.1+r604+g0b99615a8aef-1 -> 16.2.1+r23+gd564253eb6c8-1
libatomic 15.2.1+r604+g0b99615a8aef-1 -> 16.2.1+r23+gd564253eb6c8-1
libbpf 1.6.2-1 -> 1.7.0-1
libcap 2.77-1 -> 2.78-1
libcap-ng 0.9.1-1 -> 0.9.5-1
libdrm 2.4.131-1 -> 2.4.134-1
libedit 20251016_3.1-1 -> 20260512_3.1-1
libelf 0.194-2 -> 0.196-1
libevent 2.1.12-5 -> 2.1.13-2
libffi 3.5.2-1 -> 3.8.0-1
libgcc 15.2.1+r604+g0b99615a8aef-1 -> 16.2.1+r23+gd564253eb6c8-1
libgcrypt 1.12.1-1 -> 1.12.3-1
libgfortran 15.2.1+r604+g0b99615a8aef-1 -> 16.2.1+r23+gd564253eb6c8-1
libgomp 15.2.1+r604+g0b99615a8aef-1 -> 16.2.1+r23+gd564253eb6c8-1
libgpg-error 1.59-1 -> 1.61-1
libksba 1.6.8-1 -> 1.8.1-1
liblsan 15.2.1+r604+g0b99615a8aef-1 -> 16.2.1+r23+gd564253eb6c8-1
libmakepkg-dropins 20-1 -> 20-2
libmd 1.1.0-2 -> 1.2.0-1
libnetfilter_conntrack 1.0.9-2 -> 1.1.1-1
libnghttp2 1.68.0-1 -> 1.70.0-1
libnghttp3 1.15.0-1 -> 1.18.0-1
libngtcp2 1.21.0-1 -> 1.25.0-1
libnm 1.56.0-1 -> 1.58.1-1
libnsl 2.0.1-1 -> 2.0.1-2
libnvme 1.16.1-3 -> 1.16.2-2
libobjc 15.2.1+r604+g0b99615a8aef-1 -> 16.2.1+r23+gd564253eb6c8-1
libp11-kit 0.26.2-1 -> 0.26.5-1
libpgm 5.3.128-3 -> 5.3.128-4
libquadmath 15.2.1+r604+g0b99615a8aef-1 -> 16.2.1+r23+gd564253eb6c8-1
libsodium 1.0.21-1 -> 1.0.22-1
libssh 0.12.0-1 -> 0.12.2-1
libssh2 1.11.1-1 -> 1.11.1-7
libstdc++ 15.2.1+r604+g0b99615a8aef-1 -> 16.2.1+r23+gd564253eb6c8-1
libsysprof-capture 49.0-2 -> 50.0-6
libtsan 15.2.1+r604+g0b99615a8aef-1 -> 16.2.1+r23+gd564253eb6c8-1
libubsan 15.2.1+r604+g0b99615a8aef-1 -> 16.2.1+r23+gd564253eb6c8-1
libunistring 1.4.1-1 -> 1.4.2-1
liburing 2.14-1 -> 2.15-1
libusb 1.0.29-1 -> 1.0.30-1
libuv 1.52.1-1 -> 1.52.1-2
libverto 0.3.2-5 -> 0.3.2-6
libxdp 1.6.2-1 -> 1.6.3-2
libxml2 2.15.2-1 -> 2.15.3-1
linux 6.19.8.arch1-1 -> 7.1.11.arch1-1
linux-api-headers 6.19-1 -> 7.2-1
linux-firmware 20260309-1 -> 20260810-2
linux-firmware-amdgpu 20260309-1 -> 20260810-2
linux-firmware-atheros 20260309-1 -> 20260810-2
linux-firmware-broadcom 20260309-1 -> 20260810-2
linux-firmware-cirrus 20260309-1 -> 20260810-2
linux-firmware-intel 20260309-1 -> 20260810-2
linux-firmware-mediatek 20260309-1 -> 20260810-2
linux-firmware-nvidia 20260309-1 -> 20260810-2
linux-firmware-other 20260309-1 -> 20260810-2
linux-firmware-radeon 20260309-1 -> 20260810-2
linux-firmware-realtek 20260309-1 -> 20260810-2
linux-firmware-whence 20260309-1 -> 20260810-2
log4cplus 2.1.2-1 -> 2.2.0.1-1
luajit 2.1.1772619647+659a616-1 -> 2.1.1787165859+1ee778a-1
mariadb 12.2.2-2 -> 12.3.3-2
mariadb-clients 12.2.2-2 -> 12.3.3-2
mariadb-libs 12.2.2-2 -> 12.3.3-2
mkinitcpio 40-4 -> 41.1-1
mpdecimal 4.0.1-1 -> 4.0.1-3
nano 8.7.1-1 -> 9.2-1
ncurses 6.6-1 -> 6.6-2
nettle 3.10.2-1 -> 4.0-1
networkmanager 1.56.0-1 -> 1.58.1-1
nspr 4.38.2-1 -> 4.40-1
nss 3.121-1 -> 3.128-1
openbsd-netcat 1.234_2-1 -> 1.238_1-1
openssh 10.2p1-2 -> 10.5p1-1
openssl 3.6.1-1 -> 3.6.4-1
p11-kit 0.26.2-1 -> 0.26.5-1
pacman 7.1.0.r9.g54d9411-1 -> 7.1.0.r9.g54d9411-2
pacman-mirrorlist 20260213-1 -> 20260610-1
pambase 20250719-1 -> 20260616-1
pciutils 3.14.0-1 -> 3.15.0-1
pcre 8.45-4 -> 8.45-5
pcsclite 2.4.1-1 -> 2.5.1-1
perl 5.42.0-1 -> 5.42.2-2
pinentry 1.3.2-2 -> 1.3.3-1
postgresql-libs 18.3-2 -> 18.6-1
powerdns 5.0.3-1 -> 5.1.4-4
procps-ng 4.0.6-1 -> 4.0.7-1
psmisc 23.7-1 -> 23.7-2
python 3.14.3-1 -> 3.14.7-1
quiche 0.26.1-1 -> 0.29.3-1
re2 2:2025.11.05-1 -> 2:2025.11.05-6
refind 0.14.2-2 -> 0.14.2-3
sed 4.9-3 -> 4.10-2
shadow 4.18.0-1 -> 4.20.0.arch1-1
sqlite 3.52.0-1 -> 3.53.4-1
strace 6.19-1 -> 7.0-1
systemd 259.5-1 -> 261.2-1
systemd-libs 259.5-1 -> 261.2-1
systemd-sysvcompat 259.5-1 -> 261.2-1
tar 1.35-2 -> 1.35-5
tinycdb 0.81-1 -> 0.81-2
tpm2-tss 4.1.3-1 -> 4.2.0-2
tzdata 2026a-1 -> 2026c-1
util-linux 2.41.3-2 -> 2.42.2-1
util-linux-libs 2.41.3-2 -> 2.42.2-1
vim 9.2.0204-1 -> 9.2.1011-1
vim-runtime 9.2.0204-1 -> 9.2.1011-1
wget 1.25.0-3 -> 1.25.0-6
wpa_supplicant 2:2.11-5 -> 2:2.12-1
xz 5.8.2-1 -> 5.8.3-1
```
