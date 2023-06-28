const { ethers, upgrades } = require("hardhat");

// TO DO: Place the address of your proxy here!
const proxyAddress = "0x4725A08F85461D4c89e1Ae578F2C852678578Fc1";

async function main() {
  const VendingMachineV3 = await ethers.getContractFactory("VendingMachineV3");
  const upgraded = await upgrades.upgradeProxy(proxyAddress, VendingMachineV3, [
    100,
  ]);

  const implementationAddress = await upgrades.erc1967.getImplementationAddress(
    proxyAddress
  );

  // console.log("The current contract owner is: " + upgraded.owner().address);
  console.log("Implementation contract address: " + implementationAddress);
}

main();
