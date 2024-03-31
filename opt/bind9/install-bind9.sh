#!/bin/bash
sudo apt install libjemalloc-dev
sudo apt-get install -y pkg-config
sudo apt-get install libuv1-dev
sudo apt install openssl
sudo apt install libssl-dev
sudo apt-get install libcap-dev
export CFLAGS="-Ofast"
./configure --with-jemalloc=yes --with-tuning=large --disable-doh
make
make install


vim ~/.bashrc <<- put this: export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
sudo vim /etc/ld.so.conf.d/99local.conf  <<- put this: /usr/local/lib
