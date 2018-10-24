#!/bin/bash

#kill tasks on the default port and old chain data
pid="$(lsof -t -i:30303)"
#if [ -n "$pid" ]; then
    while [ -d /proc/"$pid" ]; do
        echo "killing process with pid $pid";
        sudo kill "$pid" || break;
    done
#fi
sleep 2

rm -rf ../tracking_chain/datadir/
rm genesis_block.json
echo "removed old chain data"

ACCOUNTID1="address placeholder" # assign some random stuff
ACCOUNTID2="address placeholder" # assign anything stuff

# enable lastpipe
shopt -s lastpipe
set +m

# create new accounts before geth init
cat << EOF | geth account new --datadir ../tracking_chain/datadir | grep "Address: " | ACCOUNTID1=`cut -d "{" -f2 | cut -d "}" -f1`
bla
bla
EOF
cat << EOF | geth account new --datadir ../tracking_chain/datadir | grep "Address: " | ACCOUNTID2=`cut -d "{" -f2 | cut -d "}" -f1`
bla
bla
EOF
sleep 1

# paste account addresses from output of geth account to into genesis_block.json
jq --arg account1 ${ACCOUNTID1} --arg account2 ${ACCOUNTID2} '.alloc[$account1] += {balance:"300000000"} | .alloc[$account2] += {balance:"300000000"}' genesis_template.json > genesis_block.json
sleep 1

# initialization of genesis block
geth --datadir ../tracking_chain/datadir init $1
sleep 2

# start private testnet
cat << EOF | geth --mine --rpc --verbosity 4 --nodiscover --ws --wsorigins "*" --networkid 15 --unlock "$ACCOUNTID1, $ACCOUNTID2" --cache 512 --datadir ../tracking_chain/datadir &
bla
bla
EOF

sleep 4
echo "init done!"

##########
# DONE
# Accounts mit jq einfügen (Fehler: Ether waren nicht als String in jq angegeben)
# Mining funds können beliebigen Accounts zugewiesen werden, um diesen zu befüllen
# Chain.js und notifyAgent.js funktionieren parallel auf unterschiedlichen Accounts
# accountid aus "geth account new" greppen und in die genesis_block.json schreiben zum Prefunden
# testNet ist privat
# SmartContract notify.js gitb nichts aus
# README schreiben
##########


##########
# FRAGEN / TODO
# Fehler: Fatal: Error starting protocol stack: listen udp :30303: bind: address already in use => Port ist doch frei, siehe oben im Shellscript??
#   => jedoch: Fehler taucht nicht deterministisch auf
# WS statt IPC
# miner.start() => keine DAG-Berechnung
# POW => POA
# Review des Quellcodes der ÐApp
# 
# Aufsatz schreiben (Latex)
##########