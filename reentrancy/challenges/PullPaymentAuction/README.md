# PullPaymentAuction Challenge

Favoring [Pull Payments over Push](https://consensys.github.io/smart-contract-best-practices/development-recommendations/general/external-calls/#favor-pull-over-push-for-external-calls) can be a good way to minimize the damage done by vulnerable external calls. Switch this Auction to a Pull Payment.

**Your task**:

Fix the `withdraw()` function in the `PullPaymentAuction.sol` contract using the PullPayment pattern to prevent the `PullPaymentAuctionBlockerAttacker.sol` contract from blocking the auction `PullPaymentAuction.sol` auction from receiving new bids. Do this by extracting `highestBidder.call{value: highestBid}("");` code to its own separate, externally visible `withdrawRefund()` function.
