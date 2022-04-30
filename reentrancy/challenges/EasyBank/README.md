# EasyBank Challenge

This bank is not using the Checks-Effects-Interactions pattern. This time, its our turn to exploit it! 

The exploit starts at the steal function, where the test cases will make the initial call, sending through 100 ether. Your job is to retrieve more ether from the bank and send it all back to the `thief` address by the end of the function call.

**Your task**:

Implement the `steal()` and `fallback()` functions in the `EasyThief.sol` contract in preparation to steal money locked in the `EasyBank.sol` contract.
