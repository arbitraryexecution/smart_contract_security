const { expect } = require('chai');
const { ethers, waffle } = require('hardhat');

describe('Auction', function () {
  const provider = waffle.provider;

  const bidderBidAmount = ethers.utils.parseEther('99');
  const auctionBlockerAttackerBidAmount = ethers.utils.parseEther('100');
  const postBlockedAuctionBidAmount = ethers.utils.parseEther('101');

  let deployer, attacker, bidder;
  let auctionContract;

  before(async function () {
    //
    // SETUP SCENARIO - NO NEED TO CHANGE ANYTHING HERE
    //

    [deployer, attacker, bidder] = await ethers.getSigners();

    const auctionFactory = await ethers.getContractFactory('PullPaymentAuction');
    auctionContract = await auctionFactory.deploy();
    await auctionContract.deployed();

    auctionContract = await auctionContract.connect(bidder);

    const bidTxn = await auctionContract.bid({ value: bidderBidAmount });
    await bidTxn.wait();

    expect((await provider.getBalance(auctionContract.address)).eq(bidderBidAmount)).to.be.true;
  });

  describe('EXPLOIT FIXED', function () {
    //
    // TEST THAT EXPLOIT HAS BEEN FIXED - NO NEED TO CHANGE ANYTHING HERE
    //

    let auctionBlockerAttackerContract;

    before(async function () {
      const auctionBlockerAttackerContractFactory =
        await ethers.getContractFactory(
          'PullPaymentAuctionBlockerAttacker',
          attacker
        );
      auctionBlockerAttackerContract =
        await auctionBlockerAttackerContractFactory.deploy(
          auctionContract.address
        );
      await auctionBlockerAttackerContract.deployed();

      const blockAuctionTxn = await auctionBlockerAttackerContract.blockAuction(
        { value: auctionBlockerAttackerBidAmount }
      );
      await blockAuctionTxn.wait();
    });

    it('attacker should be able to block the auction from receiving new bids', async function () {
      await expect(auctionContract.bid({ value: postBlockedAuctionBidAmount })).to.not.be.reverted;
    });
  });
});
