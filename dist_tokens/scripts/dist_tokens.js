// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");
const ethers = hre.ethers;

async function main() {

    const [sender] = await ethers.getSigners();

    // List of all addresses
    var addrs = [
        "0x0000000000000000000000000000000000000000",
        "0x000000000000000000000000000000000000dEaD",
    ]

    // Send out ETH to all recipients
    var tx;
    for (var i=0; i < addrs.length; i++) {
        console.log("Sending 1 ETH to " + addrs[i])
        tx = await sender.sendTransaction({value: ethers.utils.parseEther("1"), to: addrs[i]})
    }

    // wait for the last transaction
    await tx.wait()


}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
