const { assert } = require("chai");
const { ethers } = require("hardhat");

describe("Contracts5", () => {
    let behavior, heroContract, badFriend, goodFriend;
    beforeEach(async () => {
        const Behavior = await ethers.getContractFactory("contracts/Contracts5.sol:Behavior");
        behavior = await Behavior.deploy();
        await behavior.deployed();

        const BadFriend = await ethers.getContractFactory("contracts/Contracts5.sol:BadFriend");
        badFriend = await BadFriend.deploy();
        await badFriend.deployed();

        const GoodFriend = await ethers.getContractFactory("contracts/Contracts5.sol:GoodFriend");
        goodFriend = await GoodFriend.deploy();
        await goodFriend.deployed();

        const Hero = await ethers.getContractFactory("contracts/Contracts5.sol:Hero");
        heroContract = await Hero.deploy(behavior.address, goodFriend.address);
        await heroContract.deployed();
    });

    describe("after saying hello", () => {
        let receipt;
        beforeEach(async () => {
            const tx = await heroContract.sayHello();
            receipt = await tx.wait();
        });

        it("should make the good friend feel appreciated", async () => {
            const appreciated = receipt.logs
                .map(log => goodFriend.interface.parseLog(log))
                .find(x => x.name === "Appreciated");
            assert(appreciated);
        });
    });

    describe("after saying hello to the bad friend through behavior", () => {
        beforeEach(async () => {
            // setting it to the bad friend
            await behavior.setFriend(badFriend.address);
            // this is going to selfdestruct the behavior
            await behavior.sayHello();
        });

        describe("when the hero tries to say hello", () => {
            let receipt;
            beforeEach(async () => {
                const tx = await heroContract.sayHello();
                receipt = await tx.wait();
            });
    
            it("should no longer make the good friend feel appreciated :(", async () => {
                const appreciated = receipt.logs
                    .map(log => goodFriend.interface.parseLog(log))
                    .find(x => x.name === "Appreciated");
                assert(!appreciated);
            });
    
            it("should blow up the behavior contract", async () => {
                const code = await ethers.provider.getCode(await behavior.address);
                assert.equal(code, "0x");
            });
        });
    });
});
