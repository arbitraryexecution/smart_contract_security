const { assert, expect } = require("chai");
const { ethers } = require("hardhat");

describe("Contracts3", () => {
    let behavior, sidekick, hq, notHQ;
    beforeEach(async () => {
        [hq, notHQ] = await ethers.provider.listAccounts();

        const Behavior = await ethers.getContractFactory("contracts/Contracts3.sol:Behavior");
        behavior = await Behavior.deploy();
        await behavior.deployed();

        const Sidekick = await ethers.getContractFactory("contracts/Contracts3.sol:Sidekick");
        sidekick = await Sidekick.deploy(hq, behavior.address);
        await sidekick.deployed();
    });

    describe("after sending the alert from hq", () => {
        beforeEach(async () => {
            await sidekick.alert(5, true);
        });

        it("should record the ambush", async () => {
            const ambush = await sidekick.ambush();

            assert(ambush.alerted);
            assert.equal(ambush.enemies, 5);
            assert.equal(ambush.armed, true);
        });
    });

    describe("after sending the alert from not hq", () => {
        it("should revert", async () => {
            const signer = ethers.provider.getSigner(notHQ);

            await expect(sidekick.connect(signer).alert(5, true)).to.be.reverted;
        });
    });
});
