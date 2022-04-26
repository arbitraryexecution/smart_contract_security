# Description
Very simple token that partially implements the ERC20 spec.

# Setup

## Install Dependencies
```
$ npm i
```

## Compile contracts
```
$ npx hardhat compile
```

## Clean build artifacts
```
$ npx hardhat clean
```

## Convert bytecode hex to bytes to be used by Ghidra
```
$ python3 ../convert_hex_to_bin.py <input_file.hex> <output_file.evm>
```