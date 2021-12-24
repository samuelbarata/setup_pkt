#!/bin/bash

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
fi

if [ "$OS" = "Amazon Linux" ]; then
    sudo yum -y install cargo git vim screen gcc clang
else
    sudo apt update
    sudo apt install gcc git clang make -y
fi

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && mkdir ~/packet && cd ~/packet && git clone https://github.com/cjdelisle/packetcrypt_rs && cd packetcrypt_rs
source $HOME/.cargo/env
cargo clean
CC=clang cargo build --release
screen -dmS pkt ~/packet/packetcrypt_rs/target/release/packetcrypt ann -p pkt1qlmpz5ge4krls398f4zp2j9290g3eg2ykfk3ugx http://pool.srizbi.com http://pktpool.1024-pkt.barata.pt http://pktworld.1024-pkt.barata.pt
