const DigitalAsset = artifacts.require("DigitalAsset");

module.exports = function (deployer) {
  deployer.deploy(DigitalAsset);
};
