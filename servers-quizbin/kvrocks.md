# Kvrocks

## Setup
```bash
sudo apt update
sudo apt install -y git build-essential cmake libtool python3 libssl-dev

git clone https://github.com/apache/kvrocks.git
cd kvrocks
./x.py build -DENABLE_OPENSSL=ON -DENABLE_LUAJIT=ON -DCMAKE_BUILD_TYPE=Release
```
