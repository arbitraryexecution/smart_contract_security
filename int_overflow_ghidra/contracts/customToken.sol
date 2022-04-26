//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract MyToken {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply;

    string private _name = "PBWaffles";
    string private _symbol = "WAFF";

    constructor(uint _amount) {
        require(_amount > 0, "Must specify how many tokens to create");
        _totalSupply = _amount;
        _balances[msg.sender] = _amount;       
    }

    function name() public view returns (string memory) {
        return _name;
    }
    function symbol() public view returns (string memory) {
        return _symbol;
    }
    function decimals() public pure returns (uint8) {
        return 18;
    }
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return _balances[_owner];
    }
    function unsafeTransfer(address _to, uint256 _value) public returns (bool success) {
        uint256 senderBalance = _balances[msg.sender];
        unchecked {
            _balances[msg.sender] = senderBalance - _value;
            _balances[_to] += _value;
        }
        return true;
    }

    function safeTransfer(address _to, uint256 _value) public returns (bool success) {
        uint256 senderBalance = _balances[msg.sender];
        _balances[msg.sender] = senderBalance - _value;
        _balances[_to] += _value;
        return true;
    }
}