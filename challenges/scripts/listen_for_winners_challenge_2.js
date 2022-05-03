// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const { ethers } = require("hardhat");
const hre = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const addr = "0x0B5D489F885Ba95BE2fB72cbEa746e3b2b221De4";
  if (addr == "0x0") {
    console.log("Please set the contract addr");
    return;
  }

  console.log(`Listening for winners at: ${addr}`);
  const abi = ["event Winner(address)"];
  const [wallet] = await ethers.getSigners();

  var challenge = new ethers.Contract(addr, abi, wallet);
  // https://github.com/ethers-io/ethers.js/issues/615#issuecomment-848991047
  // Change the polling interval from 4000ms to 1000ms for the event listener
  challenge.provider.pollingInterval = 1000;
  challenge.on('Winner', (addr) => {
    console.log(`${ addr } won the game!`);
  });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main();
