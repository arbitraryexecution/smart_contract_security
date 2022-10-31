//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Challenge2 {
    event Winner(address);
    uint public a;
    uint public b;

    function setVar1(uint _a) external {
        a = _a;
    }

    function setVar2(uint _b) external {
        b = _b;
    }

    function callMe() external {
        require(msg.sender != tx.origin, "Must be called from a contract!");
        require(a*b == 42, "Not the answer");
        emit Winner(tx.origin);
    }
}
