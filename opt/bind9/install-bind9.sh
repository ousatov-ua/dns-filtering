#!/bin/bash
sudo apt install libjemalloc-dev
sudo apt-get install -y pkg-config
sudo apt-get install libuv1-dev
sudo apt install openssl
sudo apt install libssl-dev
sudo apt-get install libcap-dev
sudo apt install libprotobuf-c-dev
sudo apt install libfstrm-dev
export CFLAGS="-Ofast -pipe -march=native"
export CXXFLAGS="-Ofast -pipe -march=native"
export CPPFLAGS="-Ofast -pipe -march=native"
./configure --with-libxml2 --with-jemalloc=yes --prefix=/usr --with-openssl --with-json-c --with-libsystemd --enable-dnstap --enable-tcp-fastopen --with-tuning=large --disable-pthread-rwlock
make
make install


vim ~/.bashrc <<- put this: export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/lib"
sudo vim /etc/ld.so.conf.d/99local.conf  <<- put this: /usr/local/lib
