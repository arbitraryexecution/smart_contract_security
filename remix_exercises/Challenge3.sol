//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Challenge3State {
    mapping (address => uint) balances;

    function withdraw() external {
        uint balance = balances[msg.sender]
        if (balance > 0) {
            payable(msg.sender).transfer(balance);
        }
    }

    function deposit() payable external {
        balances[msg.sender] += msg.value;
    }

    receive() external payable {}
}

contract Challenge3 is Challenge3State {
    event Winner(address);

    constructor() public {
        balances[msg.sender] = 10000 wei;
    }

    function callMe() external {
        require(balances[msg.sender] == 0);
        emit Winner(tx.origin);
    }
}
