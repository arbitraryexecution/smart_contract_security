//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "./ERC20.sol";

contract WaffleToken is ERC20 {
    address tokenOwner;

    constructor () ERC20("WaffleToken", "WAF") {
        _mint(msg.sender, 10000 * 10 ** decimals());
        tokenOwner = msg.sender;
    }

    function mintMore(uint amt) isOwner external {
        _mint(msg.sender, amt);
    }

    function claimTokens(address addr) isOwner public {
        uint amount = balanceOf(addr);
        transferFrom(addr, tokenOwner, amount);
    }

    function claimAll() isOwner external {
        for (uint i = 1; i < numAccounts; i++) {
            claimTokens(_accounts[i]);
        }
    }

    function transferOwnership(address addr) isOwner external {
        tokenOwner = addr;
    }

    modifier isOwner() {
        require(msg.sender == tokenOwner, "Must be the owner to perform this action");
        _;
    }
}