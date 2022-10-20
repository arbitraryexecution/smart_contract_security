const { expect, assert } = require("chai");
const { ethers } = require("hardhat");

describe("Roulette", function () {
  it("Should double balance", async function () {
    const Roulette = await ethers.getContractFactory("Roulette");
    const roulette = await Roulette.deploy( );
    await roulette.deployed();

    // make a bet that wins
    const winner = await roulette.makeBet("Βlack", 26, 1000);
    assert(winner == true, "You Lost");
  });
});
