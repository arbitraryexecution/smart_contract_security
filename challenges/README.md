# Description
This directory does not contain the source code for the challenges. A user will have to
analyze the bytecode at the following addresses on Goerli in order to emit a `Winner` event and solve the
challenge.
```
Challenge 1 (Goerli): [0x67dDfD9E73D58fEB5234258EEC31AD67DE5948bc](http://goerli.etherscan.io/address/0x67dDfD9E73D58fEB5234258EEC31AD67DE5948bc)
Challenge 2 (Goerli): [0x0B5D489F885Ba95BE2fB72cbEa746e3b2b221De4](https://goerli.etherscan.io/address/0x0b5d489f885ba95be2fb72cbea746e3b2b221de4)
```

This hardhat project contains scripts that a user has to modify in order to correctly solve the
challenges.

# Solve the challenges once the required modifications have been made!
```
$ npx hardhat run --network goerli scripts/solve_challenge_1.js
$ npx hardhat run --network goerli scripts/solve_challenge_2.js
```