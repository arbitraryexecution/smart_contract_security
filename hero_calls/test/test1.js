const { assert } = require("chai");
const { ethers } = require("hardhat");

describe("Contracts1", () => {
    let hero, sidekick;
    before(async () => {
        const Hero = await ethers.getContractFactory("contracts/Contracts1.sol:Hero");
        hero = await Hero.deploy();
        await hero.deployed();

        const Sidekick = await ethers.getContractFactory("contracts/Contracts1.sol:Sidekick");
        sidekick = await Sidekick.deploy();
        await sidekick.deployed();
    });

    describe("after sending the alert", () => {
        before(async () => {
            await sidekick.sendAlert(hero.address);
        });

        it("should have the sidekick alert the hero", async () => {
            const alerted = hero.alerted;

            assert(alerted);
        });
    });
});
