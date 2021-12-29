#!/bin/bash

DIF=2048

ADDRESS='pkt1qlmpz5ge4krls398f4zp2j9290g3eg2ykfk3ugx'
POOLS1024='http://pool.srizbi.com http://pktpool.1024-pkt.barata.pt http://pktworld.1024-pkt.barata.pt http://pool.pkteer.com'
POOLS2048='http://pool.pkt.world http://pool.pktpool.io http://pool.pkteer.com'

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
fi

if [ "$OS" = "Amazon Linux" ]; then
    sudo yum -y install git vim screen gcc clang
else
    sudo apt update
    sudo apt install gcc git clang make -y
fi

rm -rf packet
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && mkdir ~/packet && cd ~/packet && git clone https://github.com/cjdelisle/packetcrypt_rs && cd packetcrypt_rs
source /root/.cargo/env
cargo clean
CC=clang cargo build --release

if [ "$DIF" -eq "1024" ]; then
  screen -dmS pkt ~/packet/packetcrypt_rs/target/release/packetcrypt ann -p $ADDRESS $POOLS1024
fi
if [ "$DIF" -eq "2048" ]; then
  screen -dmS pkt ~/packet/packetcrypt_rs/target/release/packetcrypt ann -p $ADDRESS $POOLS2048
fi
