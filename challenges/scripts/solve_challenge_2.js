// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const { ethers } = require("hardhat");
const hre = require("hardhat");

async function main() {

  // XXX: Insert address here
  const addr = "0x0";
  if (addr == "0x0") {
    console.log("Please set the contract addr");
    return;
  }
  
  const abi = ["event Winner(address winnerAddr)"];

  const [wallet] = await ethers.getSigners();

  var ch2 = new ethers.Contract(addr, abi, wallet);

  // XXX: Insert function selector here
  var func_selector = "0x0"
  // XXX: Pack the function selector and any args here (replace with correct values and the correct number of args)
  var packed_data = ethers.utils.solidityPack(["bytes4", "uint", "uint", "uint"], [func_selector, 1, 2, 3]);

  // XXX: One additional override must be set here
  var tx = await wallet.sendTransaction({
    to: ch2.address,
    data: packed_data,
  });
  var rec = await tx.wait();

  // Listen for the Winner event
  let iface = new ethers.utils.Interface(abi);
  let log;
  if (rec.logs.length != 0) {
    log = iface.parseLog(rec.logs[0]); // Here you can add your own logic to find the correct log
    console.log('Beat the challenge, Winner event emitted!')
  }
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
