#!/bin/bash
sudo apt install autoconf automake libedit-dev libsodium-dev libtool-bin pkg-config protobuf-compiler libnghttp2-dev libh2o-evloop-dev libluajit-5.1-dev libboost-all-dev libsystemd-dev libbpf-dev libclang-dev git
sudo apt install cmake
export CFLAGS="-Ofast -flto"
export CXXFLAGS="-Ofast -flto"

# install rust (install-rust.sh)
# install quich (install-quiche.sh)

./configure --enable-dns-over-tls --enable-dns-over-https --enable-dns-over-http3 --enable-dns-over-quic --with-systemd --prefix=/usr --with-quiche
make
sudo make install
