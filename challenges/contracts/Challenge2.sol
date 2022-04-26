//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Challenge2 {

    address owner;
    mapping(address => uint) balances;
    event Winner(address);

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    function something() public {
        doCalc();
    }

    // 10 is an obvious answer with a value of 1 wei
    // but students will be given the compiled contract which will make it more difficult
    function doCalc() public payable {
        /*
        require(msg.value == 1 wei);

        uint answer = input * 3 - 4;
        require(answer == 26);

        emit Winner(msg.sender);
        */
        uint answer;

        assembly {
            // Make sure that at least 1 wei is set in msg.value
            if lt(callvalue(), 1) {
                revert(0,0)
            }
            let arg := calldataload(4)
            answer := mul(arg, 3)
            answer := sub(answer, 4)

            if gt(answer, 26) {
                revert(0, 0)
            }
            if lt(answer, 26) {
                revert(0, 0)
            }
        }

        if (answer == 26) {
            emit Winner(msg.sender);
        }
    }

    function doBankThings() onlyOwner public {
        uint a = 1337 * 5 + 12 - 3 * 1337;
        balances[msg.sender] = a;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner is allowed!");
        _;
    }
}
