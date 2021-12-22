#!/bin/bash

sudo apt install screen -y
sudo apt-get update && sudo apt install gcc git -y && sudo apt install curl -y && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && sudo apt install make -y && mkdir ~/packet && cd ~/packet && git clone https://github.com/cjdelisle/packetcrypt_rs && cd packetcrypt_rs
source $HOME/.cargo/env
sudo apt install clang -y
cargo clean
CC=clang cargo build --release
screen -dmS PKT /home/$USER/packet/packetcrypt_rs/target/release/packetcrypt ann -p pkt1qju3gjk0hmv32x43nqhd7wurl730g9d4tdj0n6w http://pool.srizbi.com http://pool.pkt.world http://pool.pktpool.io

