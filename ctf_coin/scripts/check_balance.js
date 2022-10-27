// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {

  var addrToCheck = "";

  const ctf = await ethers.getContractAt("CTFToken", process.env.CTFTOKEN_ADDR);

  var balance = await ctf.balanceOf(addrToCheck);
  console.log("Balance: %s", balance);

  balance = await ctf.totalSupply();
  console.log("Total Supply: %s", balance);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
