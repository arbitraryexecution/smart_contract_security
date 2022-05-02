const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Greeter", function () {
  it("Should allow minting of flag", async function () {
    const Flag = await hre.ethers.getContractFactory("GreenFlag");
    const flag = await Flag.deploy("0x17fa14b0d73aa6a26d6b8720c1c84b50984f5c188ee1c113d2361e430f1b6764");
  
    await flag.deployed();
  
    console.log("Green Flag deployed to:", flag.address);

    // Get the current token index
    var tokenIdx = await flag.tokenIdCounter();

    // XXX: Set the correct answer here!
    var answer = 0;

    // Mint the NFT!
    var tx = await flag.mint(answer);
    await tx.wait();

    // Ensure our token was minted
    expect(tx.value).to.equal(tokenIdx);
  });
});
