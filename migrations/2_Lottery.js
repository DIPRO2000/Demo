const Lottery=artifacts.require("./Lottery.sol");

module.exports=function(deployer)
{
    const fee=1
    deployer.deploy(Lottery,fee);
}