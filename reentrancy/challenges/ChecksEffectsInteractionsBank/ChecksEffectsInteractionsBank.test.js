const { expect } = require('chai');
const { ethers, waffle } = require('hardhat');

describe('ChecksEffectsInteractionsBank', function () {
  const provider = waffle.provider;

  const depositAmount = ethers.utils.parseEther('100');

  let deployer, thief, victim;
  let bankContract;

  before(async function () {
    //
    // SETUP SCENARIO - NO NEED TO CHANGE ANYTHING HERE
    //

    [deployer, thief, victim] = await ethers.getSigners();

    const bankContractFactory = await ethers.getContractFactory('ChecksEffectsInteractionsBank');
    bankContract = await bankContractFactory.deploy();
    await bankContract.deployed();

    bankContract = await bankContract.connect(victim);

    const depositTxn = await bankContract.deposit({ value: depositAmount });
    await depositTxn.wait();

    expect(
      (await provider.getBalance(bankContract.address)).eq(depositAmount)
    ).to.be.true;
  });

  describe('EXPLOIT FIXED', function () {
    //
    // TEST THAT EXPLOIT HAS BEEN FIXED - NO NEED TO CHANGE ANYTHING HERE
    //
    
    let thiefContract;
    let thiefBeginningBalance;
    let thiefEndingBalance;

    before(async function () {
      thiefBeginningBalance = await provider.getBalance(thief.address);
    });

    before(async function () {
      const thiefContractFactory = await ethers.getContractFactory(
        'ChecksEffectsInteractionsThief',
        thief
      );
      thiefContract = await thiefContractFactory.deploy(bankContract.address);
      await thiefContract.deployed();
    });

    it('thief should not be able to withdraw more ETH than deposited via a contract', async function () {
      await expect(
        thiefContract.steal({ value: depositAmount })
      ).to.be.revertedWith('User balance insufficient for withdrawal');

      thiefEndingBalance = await provider.getBalance(thief.address);
      // not checking exact amounts here due to gas costs offseting precise balances
      expect(thiefEndingBalance.lte(thiefBeginningBalance)).to.be.true;
    });
  });
});
