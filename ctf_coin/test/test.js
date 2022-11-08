const { time, loadFixture } = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");
const { ethers, upgrades } = require("hardhat");


describe("CTF", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.

  async function deployCTFToken() {
    // Contracts are deployed using the first signer/account by default
    const [
      owner,
      user1,
      user2,
      user3,
      user4,
      user5,
      levelOneAddr,
      levelTwoAddr,
      levelThreeAddr,
      levelFourAddr,
    ] = await ethers.getSigners();

    const gas = await ethers.provider.getGasPrice()
    const CTFToken = await ethers.getContractFactory("CTFToken");
    const ctf = await upgrades.deployProxy(
      CTFToken,
      [
        "CTF Token",
        "CTF",
        levelOneAddr.address,
        levelTwoAddr.address,
        levelThreeAddr.address,
        levelFourAddr.address,
      ],
      {
        initializer: 'initialize(string,string,address,address,address,address)',
        gasPrice: gas
      }
    );
    await ctf.deployed();

    return {
      owner,
      user1,
      user2,
      user3,
      user4,
      user5,
      levelOneAddr,
      levelTwoAddr,
      levelThreeAddr,
      levelFourAddr,
      ctf,
    };
  };

  describe("Deployment", function () {
    it("Test level one", async function () {

      const {
        owner,
        user1,
        user2,
        user3,
        user4,
        user5,
        levelOneAddr,
        levelTwoAddr,
        levelThreeAddr,
        levelFourAddr,
        levelFiveAddr,
        ctf,
      } = await loadFixture(deployCTFToken);

      var tx = await ctf.connect(levelOneAddr).challengeOneSolved(user1.address);
      await tx.wait();

      tx = await ctf.connect(levelOneAddr).challengeOneSolved(user2.address);
      await tx.wait();

      tx = await ctf.connect(levelOneAddr).challengeOneSolved(user3.address);
      await tx.wait();

      tx = await ctf.connect(levelOneAddr).challengeOneSolved(user4.address);
      await tx.wait();

      /*
      Balance checks
      */
      var balance = await ctf.balanceOf(user1.address);
      expect(balance).to.equal(100);

      var balance = await ctf.balanceOf(user2.address);
      expect(balance).to.equal(85);

      var balance = await ctf.balanceOf(user3.address);
      expect(balance).to.equal(70);

      var balance = await ctf.balanceOf(user4.address);
      expect(balance).to.equal(50);

      var balance = await ctf.balanceOf(user5.address);
      expect(balance).to.equal(0);

      /*
      Ensure the winners were correctly marked
      */
      var won = await ctf.solvedChallenge(levelOneAddr.address, user1.address);
      expect(won).to.be.true;

      var won = await ctf.solvedChallenge(levelOneAddr.address, user2.address);
      expect(won).to.be.true;

      var won = await ctf.solvedChallenge(levelOneAddr.address, user5.address);
      expect(won).to.be.false;
    });

    it("Test level two", async function () {

      const {
        owner,
        user1,
        user2,
        user3,
        user4,
        user5,
        levelOneAddr,
        levelTwoAddr,
        levelThreeAddr,
        levelFourAddr,
        ctf,
      } = await loadFixture(deployCTFToken);

      var tx = await ctf.connect(levelTwoAddr).challengeTwoSolved(user1.address);
      await tx.wait();

      tx = await ctf.connect(levelTwoAddr).challengeTwoSolved(user2.address);
      await tx.wait();

      tx = await ctf.connect(levelTwoAddr).challengeTwoSolved(user3.address);
      await tx.wait();

      tx = await ctf.connect(levelTwoAddr).challengeTwoSolved(user4.address);
      await tx.wait();

      /*
      Balance checks
      */
      var balance = await ctf.balanceOf(user1.address);
      expect(balance).to.equal(100);

      var balance = await ctf.balanceOf(user2.address);
      expect(balance).to.equal(85);

      var balance = await ctf.balanceOf(user3.address);
      expect(balance).to.equal(70);

      var balance = await ctf.balanceOf(user4.address);
      expect(balance).to.equal(50);

      var balance = await ctf.balanceOf(user5.address);
      expect(balance).to.equal(0);

      /*
      Ensure the winners were correctly marked
      */
      var won = await ctf.solvedChallenge(levelTwoAddr.address, user1.address);
      expect(won).to.be.true;

      var won = await ctf.solvedChallenge(levelTwoAddr.address, user2.address);
      expect(won).to.be.true;

      var won = await ctf.solvedChallenge(levelTwoAddr.address, user5.address);
      expect(won).to.be.false;
    });
  });
});
