# Kvrocks

## Setup
```bash
sudo apt update
sudo apt install -y git build-essential cmake libtool python3 libssl-dev redis-tools

export KVROCKS_VERSION=v2.14.0
git clone -b ${KVROCKS_VERSION} https://github.com/apache/kvrocks.git
cd kvrocks
./x.py build -DENABLE_OPENSSL=ON -DENABLE_LUAJIT=ON -DCMAKE_BUILD_TYPE=Release

sudo mkdir /var/cache/kvrocks
sudo chown www-data:www-data /var/cache/kvrocks
sudo chmod 777 /var/cache/kvrocks

sudo mkdir /var/log/kvrocks
sudo chmod 777 /var/log/kvrocks
sudo chown www-data:www-data /var/log/kvrocks

./build/kvrocks -c kvrocks.conf
redis-cli -h 127.0.0.1 -p 6379 ping
# PONG
```
