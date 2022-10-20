//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

interface Challenge2 {
    function callMe(uint) external;
}

contract Challenge2 {
    event Winner(address);
    public uint secret;

    constructor(uint _secret) {
	secret = secret;
    }

    function callMe(uint _secret) external {
	require(msg.sender != tx.origin);
	require(_secret == secret);
	emit Winner(tx.origin);
    }
}
