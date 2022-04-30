# PullPaymentAuction Challenge

1. Fix the `withdraw()` function in the `PullPaymentAuction.sol` contract using the PullPayment pattern to prevent the `PullPaymentAuctionBlockerAttacker.sol` contract from blocking the auction `PullPaymentAuction.sol` auction from receiving new bids. Do this by extracting `highestBidder.call{value: highestBid}("");` code to its own separate, externally visible `withdrawRefund()` function.
