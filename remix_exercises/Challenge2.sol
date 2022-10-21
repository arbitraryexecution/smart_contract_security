//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Challenge2 {
    event Winner(address);
    public uint secret;

    constructor(uint _secret) {
        secret = secret;
    }

    function callMe(uint _secret) external {
        require(msg.sender != tx.origin, "Must be called from a contract!");
        require(_secret == secret, "Wrong password!");
        emit Winner(tx.origin);
    }
}
