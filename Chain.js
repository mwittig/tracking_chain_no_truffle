const net = require('net');
const Web3 = require('web3');
path = require('path'),
    TrackingContractJSON = require(path.join(__dirname, '../tracking_chain/build/contracts/PositionTracking.json'));

module.exports = function (callback) {
    var provider = new Web3.providers.IpcProvider('/home/telekom/Library/Ethereum/geth.ipc', net);//('ws://localhost:8546');
    var web3 = new Web3(provider);
    var account;
    var contract;

    accounts = web3.eth.getAccounts()
        .then(function (accounts) {
            // deprecated; addresses must be used
            account = accounts[0];
        }).then(function () {
            contract = new web3.eth.Contract(TrackingContractJSON.abi, TrackingContractJSON.networks['15'].address);

            contract.events.PositionValue({
            }, function (error, event) {
                if (error) console.log("error", error);
            })
                .on('data', function (event) {
                    console.log("data", event, "\n######################################\n"); // same results as the optional callback above
                })
                .on('changed', function (event) {
                    console.log("changed", event, "\n######################################\n");
                    // remove event from local database
                })
                .on('error', function (event) {
                    console.log("error 2", event, "\n######################################\n");
                })

            setInterval (sendPositionIntoBlockchain, 2000);
        });
        // .then(function (hash) {
        //     contract.methods.currentPos().send({
        //         from: account
        //     }).then(function (receipt) {
        //         console.log(receipt);
        //     });

        // }).catch(function (e) {
        //     console.log(e)
        // });
        function sendPositionIntoBlockchain ()
        {
            var x = Math.random() * (1000 - 0) + 0;
            var y = Math.random() * (1000 - 0) + 0;
            
            contract.methods.setRandomPosition(x, y).send({
                from: account
            });
        }
};

module.exports();

// var Web3 = require ('web3'),
//     contract = require ('truffle-contract'),
//     path = require ('path'),
//     TrackingContractJSON = require (path.join (__dirname, '../build/contracts/PositionTracking.json'));

// module.exports = function (callback){
//     var accounts;
//     var account;

//     var provider = new Web3.providers.HttpProvider('http://127.0.0.1:9545')

//     var TrackingContract = contract (TrackingContractJSON);

//     // https://github.com/trufflesuite/truffle-contract/issues/57
//     var web3 = new Web3(provider);
//     TrackingContract.setProvider(web3.currentProvider);
//     if (typeof TrackingContract.currentProvider.sendAsync !== "function") {
//         TrackingContract.currentProvider.sendAsync = function() {
//             return TrackingContract.currentProvider.send.apply(
//                 TrackingContract.currentProvider, arguments
//             );
//         };
//     }

//     accounts = web3.eth.getAccounts ()
//     .then (function (accounts) {
//         account = accounts[0];
//         console.log (web3.eth.defaultAccount = account);
//     })
//     .then (TrackingContract.deployed)
//     .then (function (instance) {
//         var x = Math.floor(Math.random() * Math.floor(200));
//         var y = Math.floor(Math.random() * Math.floor(200));

//         return instance.setRandomPosition (x, y, {from: account});
//     })
//     .then (function (res) {
//         console.log ("success: ", JSON.stringify(res));
//     }).catch( (err) => {
//         console.log ("error" + err);
//     });
// }

// module.exports();