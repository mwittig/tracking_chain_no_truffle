var Web3 = require('web3');

module.exports = function (callback) {
    var provider = new Web3.providers.HttpProvider('http://127.0.0.1:8545');
    var web3 = new Web3(provider);

    for (i = 0; i < 2; i++)
    {
        web3.eth.createAccount ('bla');
    }
    
    web3.eth.getAccounts ().then ((accounts) =>
    {
        web3.eth.defaultAccount = accounts[0];
        return accounts;
    }).then (console.log);
};

module.exports();