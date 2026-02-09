#!/bin/sh
RANDOM_SUFFIX=$(head -c 64 /dev/urandom | tr -dc 'A-Za-z0-9' 2>/dev/null | head -c 8)
NEW_SSID="AAAAA-$RANDOM_SUFFIX"

sed -i "s/^ssid=.*/ssid=$NEW_SSID/" /etc/hostapd/hostapd.conf
ip link set wlan0 down
systemctl stop hostapd
sleep 5
systemctl restart hostapd
ip link set wlan0 up

echo "[$(date)] Hotspot SSID changed to: $NEW_SSID"
