#!/bin/bash

#kill tasks on the default port
pid="$(lsof -t -i:30303)"
if [ -n "$pid" ]; then
    sudo kill "$pid";
fi

rm -rf ~/.ethereum_private/
rm -rf ~/.ethash/

#sleep 2
# start the private blockchain and create accounts
#cat << EOF | geth attach;
#personal.newAccount("Write here a good, randomly generated, passphrase!")
#personal.newAccount("Write here a good, randomly generated, passphrase!")
#EOF
geth --datadir ~/.ethereum_private init $1
sleep 2
cat << EOF | geth account new --datadir ~/.ethereum_private
bla
bla
EOF
cat << EOF | geth account new --datadir ~/.ethereum_private
bla
bla
EOF
cat << EOF | geth --networkid 15 --unlock "0,1" --rpc --cache 512 --ipcpath ~/Library/Ethereum/geth.ipc --networkid 12345 --datadir ~/.ethereum_private &
bla
bla
EOF
geth attach
