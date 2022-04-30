//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";

import "./Auction.sol";

contract AuctionBlockerAttacker {
    Auction auction;

    constructor(address auctionAddress) {
        auction = Auction(auctionAddress);
    }

    //
    // CHALLENGE: IMPLEMENT PART OF THE EXPLOIT HERE
    //
    receive() external payable {
    }

    //
    // CHALLENGE: USE THIS FUNCTION TO BE THE HIGHEST BIDDER
    //
    function blockAuction() external payable {
    }
}
