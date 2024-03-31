#!/bin/bash
sudo apt install autoconf automake libedit-dev libsodium-dev libtool-bin pkg-config protobuf-compiler libnghttp2-dev libh2o-evloop-dev libluajit-5.3-dev libboost-all-dev libsystemd-dev libbpf-dev libclang-dev
sudo apt install cmake
export CFLAGS="-Ofast -flto"
export CXXFLAGS="-Ofast -flto"

# install quich (quich-install.sh)

./configure --enable-dns-over-tls --enable-dns-over-https --enable-dns-over-http3 --enable-dns-over-quic --with-systemd
make
sudo make install
