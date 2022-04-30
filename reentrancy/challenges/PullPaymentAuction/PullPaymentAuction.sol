//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract PullPaymentAuction {
    address highestBidder;
    uint highestBid;
    mapping(address => uint) refunds;

    //
    // CHALLENGE: FIX THE CODE BELOW EMPLOYING THE PULL-PAYMENT PATTERN. NEW CONTRACT
    // VARIABLES MAY NEED TO BE ADDED TO IMPLEMENT THE FIX
    //
    function bid() payable external {
        require(msg.value >= highestBid);

        if (highestBidder != address(0)) {
            refunds[highestBidder] += highestBid; // record the refund that this user can claim
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
    }

    //
    // CHALLENGE: IMPLEMENT THE CODE BELOW AS PART OF THE PULL-PAYMENT PATTERN
    //
    function withdrawRefund() external {
        uint refund = refunds[msg.sender];

        // note that even though the PullPayment pattern is being used here, things are still
        // not fully secure without using the Checks-Effects-Interactions pattern as well.
        // notice the code below first updates the contract state before making a call out
        // to an untrusted contract
        refunds[msg.sender] = 0;
        (bool success, ) = msg.sender.call{value: refund}("");
        
        require(success);
    }
}
