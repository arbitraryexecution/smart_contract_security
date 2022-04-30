//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract ChecksEffectsInteractionsBank {
    mapping (address => uint) private userBalances;

    function deposit() external payable {
        userBalances[msg.sender] += msg.value;
    }

    //
    // CHALLENGE: FIX THE CODE BELOW USING CHECKS-EFFECTS-INTERACTIONS PATTERN
    //
    function withdraw() external {
        uint userBalance = userBalances[msg.sender];

        require(userBalance > 0, "User balance insufficient for withdrawal");

        userBalances[msg.sender] = 0;

        // calls msg.sender's receive() or fallback() function
        (bool success, bytes memory payload) = msg.sender.call{value: userBalance}("");
        require(success, string(payload)); 
    }
}
