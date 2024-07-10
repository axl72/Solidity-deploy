const FishmealTraceability = artifacts.require('FishmealTraceability')

module.exports = function(deployer) {
    deployer.deploy(FishmealTraceability)
}