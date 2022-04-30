//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract ReentrancyGuardBank {
    // CHALLENGE: ADD AND IMPLEMENT A REENTRACY GUARD MODIFIER HERE

    mapping (address => uint) private userBalances;

    function deposit() external payable {
        userBalances[msg.sender] += msg.value;
    }

    //
    // CHALLENGE: FIX THE CODE BELOW USING THE IMPLEMENTED REENTRANCY GUARD
    //
    function withdraw() external {
        uint userBalance = userBalances[msg.sender];

        require(userBalance > 0, "User balance insufficient for withdrawal");

        // calls msg.sender's receive() or fallback() function
        (bool success, bytes memory payload) = msg.sender.call{value: userBalance}("");
        require(success, string(payload));
        
        userBalances[msg.sender] = 0;
    }
}
