#!/bin/bash

DIF=1024

ADDRESS='pkt1q0a5l33zrmvnrym7rcvptkhyg9ppxuaryek7jhs'
POLLS1024='http://pool.srizbi.com http://pktworld.1024-pkt.barata.pt http://pktpool.1024-pkt.barata.pt http://pool.pkteer.com http://pktco.in http://pool.pktpool.io http://private-pool.leitecastro.com/'
POOLS2048='http://www.pkt.world/master/2048 http://pool.pktpool.io http://pool.pkteer.com http://private-pool.leitecastro.com/'

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

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
rm -rf ~/packet
mkdir ~/packet && wget --no-check-certificate https://barata.pt/files/pkt/packetcrypt
chmod +x packetcrypt

if [ "$DIF" -eq "1024" ]; then
  screen -dmS pkt ~/packet/packetcrypt ann -p $ADDRESS $POOLS1024
fi
if [ "$DIF" -eq "2048" ]; then
  screen -dmS pkt ~/packet/packetcrypt ann -p $ADDRESS $POOLS2048
fi
