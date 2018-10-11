#!/bin/bash

#kill tasks on the default port
pid="$(lsof -t -i:30303)"
if [ -n "$pid" ]; then
    sudo kill "$pid";
    echo "killed process with pid $pid";
fi
#sleep 2  
rm -rf ~/eth_projects/tracking_chain/datadir/
rm ~/eth_projects/tracking_chain_notruffle/genesis_block.json
echo "removed old chain data"
#rm -rf ~/.ethash/

#sleep 2
# start the private blockchain and create accounts
#cat << EOF | geth attach;
#personal.newAccount("Write here a good, randomly generated, passphrase!")
#personal.newAccount("Write here a good, randomly generated, passphrase!")
#EOF

ACCOUNTID1="14767897d33c020dc6aa5341933b8ac21e76b607"
ACCOUNTID2="9db05195a84975e6e0f9cb7151f0aaf2b5f7e867"

# enable lastpipe
shopt -s lastpipe
set +m

# create new accounts before geth init
cat << EOF | geth account new --datadir ../tracking_chain/datadir | grep "Address: " | $ACCOUNTID=`cut -d "{" -f2 | cut -d "}" -f1`
bla
bla
EOF
cat << EOF | geth account new --datadir ../tracking_chain/datadir | grep "Address: " | cut -d "{" -f2 | cut -d "}" -f1
bla
bla
EOF
sleep 1

# paste account addresses from output of geth account to into genesis_block.json
jq --arg account1 ${ACCOUNTID1} --arg account2 ${ACCOUNTID2} '.alloc[$account1] += {balance:"300000"} | .alloc[$account2] += {balance:"300000"}' genesis_template.json > genesis_block.json
sleep 1

# init
geth --port 0 --nodiscover --ws --wsport 8546 --wsorigins all --datadir ../tracking_chain/datadir init $1 #add: --netrestrict="192.168.2.1/24"
sleep 2

# start private testnet
cat << EOF | geth --verbosity 2 --networkid 15 --unlock "0,1" --rpc --cache 512 --ipcpath ~/Library/Ethereum/geth.ipc --datadir ../tracking_chain/datadir &
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
#
#
#
#
##########


##########
# FRAGEN / TODO
# accountid aus "geth account new" greppen und in die genesis_block.json schreiben zum Prefunden
# Ether überweisen, aber das sollte kein Problem sein
# Fehler: Fatal: Error starting protocol stack: listen udp :30303: bind: address already in use => Port ist doch frei, siehe oben im Shellscript??
# WS statt IPC+
#
#
#
##########