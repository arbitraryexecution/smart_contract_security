// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {

  const gas = await ethers.provider.getGasPrice()
  const CTFToken = await ethers.getContractFactory("CTFToken");
  const ctf = await upgrades.deployProxy(
    CTFToken,
    [
      "CTF Token",
      "CTF",
      process.env.CTF0_ADDR,
      process.env.CTF1_ADDR,
      process.env.CTF2_ADDR,
      "0x0000000000000000000000000000000000000000",
    ],
    {
      initializer: 'initialize(string,string,address,address,address,address)',
      gasPrice: gas
    }
  );
  await ctf.deployed();

  console.log(`CTF Coin deployed to: ${ctf.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
