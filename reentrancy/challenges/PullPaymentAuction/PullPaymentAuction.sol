//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract PullPaymentAuction {
    address highestBidder;
    uint highestBid;

    //
    // CHALLENGE: FIX THE CODE BELOW EMPLOYING THE PULL-PAYMENT PATTERN. NEW CONTRACT
    // VARIABLES MAY NEED TO BE ADDED TO IMPLEMENT THE FIX
    //
    function bid() payable external {
        require(msg.value >= highestBid);

        if (highestBidder != address(0)) {
            // if this call consistently fails, no one else can bid
            (bool success, bytes memory payload) = highestBidder.call{value: highestBid}("");
            require(success, string(payload)); // if this call consistently fails, no one else can bid
        }

       highestBidder = msg.sender;
       highestBid = msg.value;
    }

    //
    // CHALLENGE: IMPLEMENT THE CODE BELOW AS PART OF THE PULL-PAYMENT PATTERN
    //
    function withdrawRefund() external {
    }
}
