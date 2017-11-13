var BTCRelay = artifacts.require("./BTCRelay.sol");

module.exports = function(deployer) {
  deployer.deploy(BTCRelay);
};
