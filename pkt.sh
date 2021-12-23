#!/bin/bash

sudo apt install screen -y
sudo apt-get update && sudo apt install gcc git -y && sudo apt install curl -y && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && sudo apt install make -y && mkdir ~/packet && cd ~/packet && git clone https://github.com/cjdelisle/packetcrypt_rs && cd packetcrypt_rs
source $HOME/.cargo/env
sudo apt install clang -y
cargo clean
CC=clang cargo build --release
screen -dmS PKT ~/packet/packetcrypt_rs/target/release/packetcrypt ann -p pkt1q72m6djqnyqmentzlrenehrv4evntcl4fppj6l5 http://pool.srizbi.com http://pktpool.1024-pkt.barata.pt http://pktworld.1024-pkt.barata.pt

