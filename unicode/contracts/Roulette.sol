//SPDX-License-Identifier: Unlicense
pragma solidity ^0.4.22;
pragma experimental ABIEncoderV2;

import "hardhat/console.sol";

contract Roulette {

   enum Color { RED, BLACK, GREEN }

   struct betStruct { 
        Color color;
        uint number;
        uint amount;
    }

    constructor() public {

    }

    function compareStrings(string memory a, string memory b) pure internal returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }

    function isWinner(betStruct bet) view internal returns (bool) {
        if (bet.color == Color.BLACK && bet.number == 26) {
            console.log("You Won:", bet.amount*35);
            return true;
        }
        else {
            console.log("You Lost");
            return false;
        }
    }

    function makeBet(string colorString, uint number, uint amount) public view returns (bool) {
        betStruct memory bet;
        bet.number = number;
        bet.amount = amount;

        if (compareStrings(colorString, "Red")) {
            bet.color = Color.RED;
        }
        else if (compareStrings(colorString, "Βlack")) {
            bet.color = Color.BLACK;
        }
        else {
            bet.color = Color.GREEN;
        }
            
        return isWinner(bet);
    }
}
