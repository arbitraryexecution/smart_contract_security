### bZx exploit lab

## Getting started
1. `npm i`
2. put your private alchemy api key in the .env file

- create and edit `.env` file
- add `ALCHEMYURL="<your key here>"` on the first line
3. fill in exploit contract in `./contracts/Exploit.sol`
4. test with npm exploit

## Tips

- use hardhat's console functions (logString, logUint, etc)
- do NOT use `^` to raise to the power in solidity, the correct syntax is `**` ex: `7500*10**18`
- don't be afraid to ask questions, this is a longer lab
