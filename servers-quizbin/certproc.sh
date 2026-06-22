#!/usr/bin/env bash

# Backup certificates directory
mv -v certs certs-<yyyymmdd>
mkdir certs

# Provision an ephemeral ArchLinux container
docker run -it --rm -v /home/johnpaul/certs:/certs archlinux:base /bin/bash

#-=============================================================================
# Ephemeral commands:
#-=============================================================================

pacman -Syyu
pacman -S wget git bind
cd ~
git clone https://github.com/acmesh-official/acme.sh.git
cd ~/acme.sh
mkdir ~/.acme.sh
./acme.sh --install -m <PUT-EMAIL-HERE> --set-default-ca --server zerossl

./acme.sh --install -m <PUT-EMAIL-HERE> --set-default-ca --server zerossl --eab-kid <PUT-KID-HERE> --eab-hmac-key <PUT-KEY-HERE>
./acme.sh --register-account --eab-kid <PUT-KID-HERE> --eab-hmac-key <PUT-KEY-HERE>

dig _acme-challenge.tindango.com TXT

./acme.sh --issue -d '*.tindango.com' --dns --yes-I-know-dns-manual-mode-enough-go-ahead-please
./acme.sh --issue -d '*.tindango.com' --dns --yes-I-know-dns-manual-mode-enough-go-ahead-please --renew

./acme.sh --issue -d tindango.com --dns --yes-I-know-dns-manual-mode-enough-go-ahead-please
./acme.sh --issue -d tindango.com --dns --yes-I-know-dns-manual-mode-enough-go-ahead-please --renew

dig _acme-challenge.quizbin.com TXT

./acme.sh --issue -d '*.quizbin.com' --dns --yes-I-know-dns-manual-mode-enough-go-ahead-please
./acme.sh --issue -d '*.quizbin.com' --dns --yes-I-know-dns-manual-mode-enough-go-ahead-please --renew

./acme.sh --issue -d quizbin.com --dns --yes-I-know-dns-manual-mode-enough-go-ahead-please
./acme.sh --issue -d quizbin.com --dns --yes-I-know-dns-manual-mode-enough-go-ahead-please --renew

cp -Rv /root/.acme.sh /certs/

exit

#-=============================================================================
# Host commands:
#-=============================================================================

mkdir /hostmp/certs
cp -Rv /home/johnpaul/certs/ /hostmp/certs/
