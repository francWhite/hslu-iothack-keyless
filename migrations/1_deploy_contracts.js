const Keyless = artifacts.require("Keyless");

module.exports = function(deployer) {
  deployer.deploy(Keyless);
};
