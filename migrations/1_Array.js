const ArrayContract = artifacts.require("./Array.sol");

module.exports = function (deployer) {
  deployer.deploy(ArrayContract);
};