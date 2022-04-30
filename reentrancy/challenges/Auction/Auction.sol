//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract Auction {
    address highestBidder;
    uint highestBid;

    function bid() payable external {
        require(msg.value >= highestBid);

        if (highestBidder != address(0)) {
            // if this call consistently fails, no one else can bid
            (bool success, bytes memory payload) = highestBidder.call{value: highestBid}("");
            require(success, string(payload));
        }

       highestBidder = msg.sender;
       highestBid = msg.value;
    }
}
