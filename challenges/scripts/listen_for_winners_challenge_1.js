// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const { ethers } = require("hardhat");
const hre = require("hardhat");
const wled = require('../../wled_integration');

async function main() {
  // Addr of NFT contract
  const addr = "0xe42a6fC1aC0c4CCa1ABaE1B174B7D020652BA259";
  if (addr == "0x0") {
    console.log("Please set the contract addr");
    return;
  }

  console.log(`Listening for winners at: ${addr}`);
  const abi = ["event Transfer(address indexed from, address indexed to, uint256 indexed tokenId)"];
  const [wallet] = await ethers.getSigners();

  var challenge = new ethers.Contract(addr, abi, wallet);

  // https://github.com/ethers-io/ethers.js/issues/615#issuecomment-848991047
  // Change the polling interval from 4000ms to 1000ms for the event listener
  challenge.provider.pollingInterval = 1000;
  // Save off the old state
  var currentState = await wled.get();

  let filter = challenge.filters.Transfer("0x0000000000000000000000000000000000000000", null);
  challenge.once(filter, async (srcAddr, dstAddr, tokenId) => {

    if (srcAddr == "0x0000000000000000000000000000000000000000") {

      console.log(`${ dstAddr } won the game!`);

      // Do the WLED stuff
      await wled.changeToGreen();
      // Keep it red for 15 seconds
      await wled.delay(15000);
      // Restore the original colors
      await wled.restoreState(currentState);
    }
  });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main();
