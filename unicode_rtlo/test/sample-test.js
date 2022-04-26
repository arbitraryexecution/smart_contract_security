const { expect, assert } = require("chai");
const { ethers } = require("hardhat");

describe("GuessTheNumber", function () {
  it("Should guess the correct number", async function () {
    const GuessTheNumber = await ethers.getContractFactory("GuessTheNumber");
    const guess = await GuessTheNumber.deploy(5);
    await guess.deployed();

    const overrides = {
      value: ethers.utils.parseEther("1.0"), //sending one ether
    }

    const transaction = await guess.guess(5, overrides);
    const receipt = await transaction.wait();
    const result = receipt.events?.filter((x) => {
      return x.event == "result";
    });

    const eventArgs = result[0].args;
    assert.equal(eventArgs[0], "You guessed the correct number!");    
  });
});
