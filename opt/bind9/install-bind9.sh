#!/bin/bash
sudo apt install libjemalloc-dev
sudo apt-get install -y pkg-config
sudo apt-get install libuv1-dev
sudo apt install openssl
sudo apt install libssl-dev
sudo apt-get install libcap-dev
sudo apt install libprotobuf-c-dev
sudo apt install libfstrm-dev llvm-16-dev
export CFLAGS="-O3 -pipe -march=znver3 -flto"
export CXXFLAGS="-O3 -pipe -march=znver3 -flto"
export CPPFLAGS="-O3 -pipe -march=znver3 -flto"
./configure --with-libxml2 --with-jemalloc=yes --prefix=/usr --with-openssl --with-json-c --with-libsystemd --enable-dnstap --enable-tcp-fastopen --with-tuning=large --disable-pthread-rwlock --disable-doh
make
make install

sudo groupadd named
sudo adduser --home /var/lib/named --disabled-login named


vim ~/.bashrc <<- put this: export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
sudo vim /etc/ld.so.conf.d/99local.conf  <<- put this: /usr/local/lib
