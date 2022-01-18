#!/bin/bash

DIF=10242

ADDRESS='pkt1q0a5l33zrmvnrym7rcvptkhyg9ppxuaryek7jhs'
POOLS1024='http://pool.srizbi.com http://pktpool.1024-pkt.barata.pt http://pktworld.1024-pkt.barata.pt http://pool.pkteer.com'
POLLS1024_2='http://pool.srizbi.com http://pktworld.1024-pkt.barata.pt http://pktpool.1024-pkt.barata.pt http://pool.pkteer.com http://pktco.in http://pool.pktpool.io'
POOLS2048='http://www.pkt.world/master/2048 http://pool.pktpool.io http://pool.pkteer.com'

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
fi

if [ "$OS" = "Amazon Linux" ]; then
    sudo yum -y install git vim screen gcc clang
else
    sudo apt update
    sudo apt install gcc git clang make screen -y
    export HOME=/root
fi

rm -rf ~/packet
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && mkdir ~/packet && cd ~/packet && git clone https://github.com/cjdelisle/packetcrypt_rs && cd packetcrypt_rs
source $HOME/.cargo/env
cargo clean
CC=clang cargo build --release

if [ "$DIF" -eq "1024" ]; then
  screen -dmS pkt ~/packet/packetcrypt_rs/target/release/packetcrypt ann -p $ADDRESS $POOLS1024
fi
if [ "$DIF" -eq "10242" ]; then
  screen -dmS pkt ~/packet/packetcrypt_rs/target/release/packetcrypt ann -p $ADDRESS $POOLS1024_2
fi
if [ "$DIF" -eq "2048" ]; then
  screen -dmS pkt ~/packet/packetcrypt_rs/target/release/packetcrypt ann -p $ADDRESS $POOLS2048
fi
