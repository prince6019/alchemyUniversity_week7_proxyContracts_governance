const { ethers, upgrades } = require("hardhat");

// TO DO: Place the address of your proxy here!
const proxyAddress = "0xaD442Ea23fcf55594a6af4A5e65f8A61A207ab22";

async function main() {
  const VendingMachineV3 = await ethers.getContractFactory("VendingMachineV3");
  const upgraded = await upgrades.upgradeProxy(proxyAddress, VendingMachineV3);

  const implementationAddress = await upgrades.erc1967.getImplementationAddress(
    proxyAddress
  );

  // console.log("The current contract owner is: " + upgraded.owner().address);
  console.log("Implementation contract address: " + implementationAddress);
}

main();
