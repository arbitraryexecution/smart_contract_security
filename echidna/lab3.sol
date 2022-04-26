// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.7.6;

/**
 * @title SimpleBank
 * @dev Lets people deposit and withdraw funds
 */
contract SimpleBank {
    mapping(address => uint256) public balances;
    uint256 minimumBalance = 1 ether;

    /**
     * @dev Deposit funds into contract
     */
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    /**
     * @dev Withdraw funds from contract
     * @param amount - The amount of ether to withdraw
     */
    function withdraw(uint256 amount) public checkMinimumAndUnderflow(amount) {
        balances[msg.sender] -= amount;

        (bool sent,) = payable(msg.sender).call{value: amount}("");
        require(sent, "Failed to withdraw Ether");
    }

    /**
     * @dev Burns a specified amount of ETH - This will cause the balance of msg.sender
     *      to be deducted but the ETH will still be held by the contract
     * @param amount - The amount to ether to burn
     */
    function burn(uint256 amount) public checkMinimumAndUnderflow(amount) {
        balances[msg.sender] -= amount;
    }

    /**
     * @dev Checks for to ensure that:
     *          - msg.sender has a least the specified minimum balance
     *          - The remaining balance after amount is subtracted from the balance is still over
     *            the minimumBalance
     *          - The specified amount of ether to deduct does not cause an underflow
     * @param amount - The amount expected to deduct from the msg.sender's balance
     */
    modifier checkMinimumAndUnderflow(uint256 amount) {
        // check for minimum balance
        require(balances[msg.sender] > minimumBalance, "Can't remove funds if you have less than the minimum balance");
        require(balances[msg.sender] - amount >= minimumBalance, "Cannot remove funds under minimum balance");

        // check for underflow
        require(amount < balances[msg.sender] + minimumBalance, "Underflow detected! Reverting!");
        _;
    }

    // *** ECHIDNA FUZZING BELOW ***
    uint256 totalDeposited = 0;

    function echidna_test() public returns (bool){
        // echidna test logic goes here
    }

    // TODO 
    // 1. Track total amount of ether deposited to the contract
    // 2. Implement logic in echidna_test to return false if an incorrect state arises
}
