var Web3 = require('web3');
path = require('path'),
    TrackingContractJSON = require(path.join(__dirname, '../tracking_chain/build/contracts/PositionTracking.json'));

module.exports = function (callback) {
    var provider = new Web3.providers.HttpProvider('http://127.0.0.1:8545');
    var web3 = new Web3(provider);
    var TrackingContract = new web3.eth.Contract(TrackingContractJSON.abi);

    accounts = web3.eth.getAccounts ()
    .then (function (accounts) {
        account = accounts[0];
        console.log (web3.eth.defaultAccount = account);
    })
    .then (TrackingContract.deployed)
    .then (function (instance) {
        var x = Math.floor(Math.random() * Math.floor(200));
        var y = Math.floor(Math.random() * Math.floor(200));

        return instance.setRandomPosition (x, y, {from: account});
    })
    .then (function (res) {
        console.log ("success: ", JSON.stringify(res));
    }).catch( (err) => {
        console.log ("error" + err);
    });
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