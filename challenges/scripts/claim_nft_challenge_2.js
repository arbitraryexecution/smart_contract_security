// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const flag = await hre.ethers.getContractAt("RedFlag", "0x19d4e9bfd551D478814EC686113Ba9Ffa1638407")
  console.log("Red Flag address:", flag.address);

  // XXX: Set the correct answer and value here!
  var answer = 0;
  var value = 0;

  // Mint the NFT!
  var tx = await flag.mint(answer, value);
  await tx.wait();
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
