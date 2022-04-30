const { expect } = require('chai');
const { ethers, waffle } = require('hardhat');

describe('EasyBank', function () {
  const provider = waffle.provider;

  const depositAmount = ethers.utils.parseEther('100');

  let deployer, thief, victim;
  let bankContract;

  before(async function () {
    //
    // SETUP SCENARIO - NO NEED TO CHANGE ANYTHING HERE
    //

    [deployer, thief, victim] = await ethers.getSigners();

    const BankContractFactory = await ethers.getContractFactory('EasyBank');
    bankContract = await BankContractFactory.deploy();
    await bankContract.deployed();

    bankContract = await bankContract.connect(victim);

    const depositTxn = await bankContract.deposit({ value: depositAmount });
    await depositTxn.wait();

    expect((await provider.getBalance(bankContract.address)).eq(depositAmount)).to.be.true;
  });

  describe('EXPLOIT', function() {
    let thiefContract;
    let thiefBeginningBalance;
    let thiefEndingBalance;

    before(async function () {
      thiefBeginningBalance = await provider.getBalance(thief.address);
    });

    before(async function () {
      //
      // CHALLENGE: SETUP AND EXECUTE THE EXPLOIT HERE
      //
    });

    it('thief should be able to withdraw more ETH than deposited via a contract', async function () {
      //
      // ASSERTING THIEF CAN WITHDRAW MORE ETH THAN DEPOSITED - NO NEED TO CHANGE ANYTHING HERE
      //

      // not checking exact amounts here due to gas costs offseting precise balances
      expect(thiefEndingBalance.gt(thiefBeginningBalance)).to.be.true;
    });
  });
});
