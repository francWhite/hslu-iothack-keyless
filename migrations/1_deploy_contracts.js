const Keyless = artifacts.require("Keyless");
const Dummy = artifacts.require("Dummy");

module.exports = function(deployer) {
  deployer.deploy(Keyless);
  deployer.deploy(Dummy);
};
