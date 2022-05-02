const { assert } = require("chai");
const { ethers } = require("hardhat");

describe("Contracts4", () => {
    let behavior, heroContract, heroEOA, villianEOA;
    beforeEach(async () => {
        [heroEOA, villianEOA] = await ethers.provider.listAccounts();

        const Behavior = await ethers.getContractFactory("contracts/Contracts4.sol:Behavior");
        behavior = await Behavior.deploy();
        await behavior.deployed();

        const Hero = await ethers.getContractFactory("contracts/Contracts4.sol:Hero");
        heroContract = await Hero.deploy(heroEOA, behavior.address);
        await heroContract.deployed();
    });

    describe("after supercharging", () => {
        beforeEach(async () => {
            const signer = await ethers.provider.getSigner(heroEOA);
            await signer.sendTransaction({
                to: heroContract.address,
                data: behavior.interface.encodeFunctionData("superCharge()")
            });
        });

        it("should supercharge the hero", async () => {
            const isSuperCharged = await heroContract.isSuperCharged(); 
            assert.equal(isSuperCharged, true);
        });

        describe("after attempting an ownership takeover", () => {
            beforeEach(async () => {
                const signer = await ethers.provider.getSigner(villianEOA);
                try {
                    await signer.sendTransaction({
                        to: heroContract.address,
                        data: behavior.interface.encodeFunctionData("initialize(address)", [
                            villianEOA
                        ])
                    });
                }
                catch(ex) {
                    
                }
            });

            it("should not transfer the ownership", async () => {
                const owner = await heroContract.owner();
                assert.equal(owner, heroEOA);
            });

            describe("and attempting a self-destruct", () => {
                beforeEach(async () => {
                    const signer = await ethers.provider.getSigner(villianEOA);
                    try {
                        await heroContract.connect(signer).destroy();
                    }
                    catch(ex) {
                        
                    }
                });

                it("should contain code at the Hero address", async () => {
                    const code = await ethers.provider.getCode(heroContract.address);
                    assert.notEqual(code, "0x");
                });
            });
        });
    });
});
