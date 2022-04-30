//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";

import "./EasyBank.sol";

contract EasyThief {
    address thief;
    EasyBank bank;

    constructor(address bankAddress) {
        thief = msg.sender;
        bank = EasyBank(bankAddress);
    }

    //
    // CHALLENGE: IMPLEMENT PART OF THE EXPLOIT HERE
    //
    fallback() external payable {
    }

    //
    // CHALLENGE: IMPLEMENT PART OF THE EXPLOIT HERE
    //
    function steal() external payable {
    }
}
