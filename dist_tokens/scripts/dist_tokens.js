// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");
const ethers = hre.ethers;

async function main() {

    const [sender] = await ethers.getSigners();

    const token_contract = await ethers.getContractAt("WaffleToken", "0xAd64B7edaCf83907450741ed97a8A4F230F79152");

    // List of all addresses
    const addrs = [
      "0x0000000000000000000000000000000000000000",
    ];

    // Send out ETH to all recipients
    var tx;
    for (var i=0; i < addrs.length; i++) {
      console.log(addrs[i]);
        tx = await token_contract.transfer(addrs[i], ethers.utils.parseEther("10"));
        await tx.wait();
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
