//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Challenge3 {
    event Winner(address);
    uint private secret;

    constructor(uint _secret) {
        secret = _secret;
    }

    function callMe(uint _secret) external {
        require(msg.sender != tx.origin, "Must be called from a contract!");
        require(_secret == secret, "Wrong password!");
        emit Winner(tx.origin);
    }
}
