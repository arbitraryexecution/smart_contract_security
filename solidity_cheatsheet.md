************
# Cheatsheet: [Full solidity docs](https://docs.soliditylang.org/en/latest/index.html)
************


## Pragma version
=================  
Every contract needs to specify a solidity compiler to use. This is because changes in the solidity compiler
version may introduce breaking and dangerous divergent behavior.
```
pragma solidity ^0.8.0;
```


## Function Visibility Specifiers
=================================
```
function myFunction() <visibility specifier> returns (bool) {
    return true;
}
```

- `public`: visible externally and internally (creates a `getter function<getter-functions>` for storage/state variables)
- `external`: only visible externally (only for functions) - i.e. can only be message-called (via `this.func`)
- `internal`: only visible internally
- `private`: only visible in the current contract


## Modifiers
============
```
function myFunction() <optional function modifier> <visibility specifier> returns (bool) {
    return true;
}
```
- `pure` for functions: Disallows modification or access of state
- `view` for functions: Disallows modification of state
- `payable` for functions: Allows them to receive Ether together with a call
- `virtual` for functions and modifiers: Allows the function's or modifier's
  behavior to be changed in derived contracts
- `override`: States that this function, modifier or public state variable changes
  the behavior of a function or modifier in a base contract

- `constant` for state variables: Disallows assignment (except initialization), does not occupy storage slot
- `immutable` for state variables: Allows exactly one assignment at construction time and is constant afterwards
```
uint256 constant varA;
uint256 immutable varB;
```


## Types
========
- `bool`: Boolean which is either `true` or `false`
  - Example: `bool foo = true;`
- `int/uint`: alias for `int256/uint256`
  - `int8/uint8`: 1 byte number
  - `int16/uint16`: 2 byte number
  - ...
  - `int256/uint256`: 32 byte number
- `bytesX`
  - `bytes1`: 1 byte length
  - `bytes2`: 2 byte length
  - ...
  - `bytes32`: 32 byte length
- `bytes`: encoded as a bytes1 array (`bytes foo = bytes1[] foo`)
- `string`: encoded as a bytes1 array (`string foo = bytes1[] foo`)
- `address`: holds a 20 byte value
  - Has the following functions:
    - `balance`: Ether balance
    - `call`: Issue a low level call on the address
        - msg.value can be overriden
        ```
        someContract.call{value: 1 ether}("");
        ```
    - `delegatecall`: Issue a low level delegatecall on the address
- `address payable`: same as `address` but also has the `transfer` and `send` functions
- `array`:
  - Example: `uint256[] arrayOfNumbers;`
  - Example: `arrayOfNumbers.push(10);`
  - Example: `uint256 foo = arrayOfNumbers.pop();`
- `mapping`: Same idea as a python dictionary. key-value pairing
  - Example: `mapping(address => bool) allowed;`
  - Example: `allowed[msg.sender] = true`

> **_NOTE:_** Min and max values for `int/uint` types can be done via `type(T).min` or `type(T).max`
> Example: `type(int8).min == -128` and `type(int8).max == 127`.

> **_NOTE:_** To send ether to a contract, the variable must be of type `address payable` or
> must be casted to that type via the `payable(<variable>);` syntax.

> **_WARNING:_** The low-level calls which operate on addresses rather than contract instances
> (i.e. `.call()`, `.delegatecall()`, `.staticcall()`, `.send()` and `.transfer()`) do not include a check to
> ensure the address is a smart contract and as such will not revert when attempting to call a function at that
> address. This means that `(bool success, ) = address(0x0000000000000000000000000000000000000000).call("")` will always
> set `success` to `true`.


## Error Handling
=================
- `assert(bool condition)`: reverts transaction if `condition` is false
  - Example: `assert(a + b) <= type(uint256).max`
- `require(bool condition)`: reverts transaction if `condition` is false
  - Example: `require(success)`
- `require(bool condition, string memory message)`: reverts transaction if `condition` is false and provides the
string as an error message which is used to determine why the transaction reverted
  - Example: `require(success, "Could not send funds to contract!")`
- `revert()`: reverts a transaction
  - Example: `revert()`
- `revert(string memory message)`: reverts a transaction and provides the string as an error message which is used
to determine why the transaction reverted
  - Example: `revert("This feature is not implemented yet!")`


## Number Denominations
=======================
- wei: 1 wei == 1
- gwei: 1 gwei == 1 * 10**9 == 1e9
- ether: 1 ether == 1 * 10**18 == 1e18

- seconds: 1 seconds = 1
- minutes: 1 minutes == 60 seconds
- hours: 1 hours == 60 minutes
- days: 1 days == 24 hours
- weeks: 1 weeks == 7 days


## Shift Operations
===================
- Left shift: x << y == x * 2**y
- Right shift: x >> y == x / 2**y


## Global Variables
===================
- `abi.decode(bytes memory encodedData, (...)) returns (...)`: `ABI <ABI>`-decodes
  the provided data. The types are given in parentheses as second argument
  - Example: `(uint a, uint[2] memory b, bytes memory c) = abi.decode(data, (uint, uint[2], bytes))`
- `abi.encodeWithSignature(string memory signature, ...) returns (bytes memory)`: Equivalent
  to `abi.encodeWithSelector(bytes4(keccak256(bytes(signature)), ...)`
    - Example: `address(contract).call( abi.encodeWithSignature("someFunc(uint256)", varA) )`

- `block.number` (`uint`): current block number
- `block.timestamp` (`uint`): current block timestamp in seconds since Unix epoch
- `msg.data` (`bytes`): complete calldata
- `msg.sender` (`address`): sender of the message (current call)
- `msg.sig` (`bytes4`): first four bytes of the calldata (i.e. function identifier)
- `msg.value` (`uint`): number of wei sent with the message
- `tx.origin` (`address`): sender of the transaction (full call chain)
- `keccak256(bytes memory) returns (bytes32)`: compute the Keccak-256 hash of the input
- `ecrecover(bytes32 hash, uint8 v, bytes32 r, bytes32 s) returns (address)`: recover address associated with
  the public key from elliptic curve signature, return zero on error
- `this` (current contract's type): the current contract, explicitly convertible to `address` or `address payable`
- `super`: the contract one level higher in the inheritance hierarchy
- `selfdestruct(address payable recipient)`: destroy the current contract, sending its funds to the given address

> **_NOTE:_** The global variables under the `msg` prefix can change when one contract calls another contract
> (within the same transaction). The global variables under the `tx` prefix cannot change for the duration
> of the entire transaction.

```
EoA (0x1111...) ---------------------> Contract A (0xAAAA...) ---------------------> Contract B (0xFFFF...)
                msg.sender: 0x1111...                         msg.sender: 0xAAAA...
                tx.origin: 0x1111...                          tx.origin: 0x1111...
```


## Inheritance
==============
- Contracts can inherit from other contracts
```
contract Base {
  constructor() {}

  function addNumbers(uint256 a, uint256 b) public returns (uint256) {
    return a + b;
  }
}

contract TestContract is Base {
  constructor() {}

  function foo(uint256 a, uint256 b) public {
    addNumbers(a, b);
  }
}
```
- Types can inherit from library contracts
```
library SafeMath {
  function add(uint256 a, uint256 b) public returns (uint256) {
    uint256 c = a + b;
    require(c >= a, "Operation caused an overflow!");

    return c;
  }
}

contract TestContract {
  using SafeMath for uint256;

  constructor() {}

  function addNumbers(uint256 a, uint256 b) public returns (uint256) {
    uint256 c = a.add(b);
    return c;
  }
}
```


## Common Examples
==================

### Send Ether from One Contract to Another
===========================================
```
contract TestContractA {

  address bAddr;
  address cAddr;

  constructor(address _bAddr, address _cAddr) {
    bAddr = _bAddr;
    cAddr = _cAddr;
  }

  function sendBalanceToContractB() payable public returns(uint256) {
    (bool success, bytes memory returnData) = payable(bAddr).call{value: address(this).balance}("");
    require(success);
  }

  function sendBalanceToContractC() payable public returns(uint256) {
    (bool success, bytes memory returnData) = payable(cAddr).call{value: 1 ether}("");
    require(success);
  }
}

contract TestContractB {
  receive() external payable {}
}

contract TestContractC {
  fallback() external payable {}
}
```

### Receive Ether on Contract
=============================
```
contract TestContract {

    constructor() {}

    receive() external payable {}
}
```

### Only Allow the Owner to Send Ether to Contract
==================================================
```
contract TestContract {

    address owner;

    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    modifier onlyOwner() {
      require(msg.sender == owner, "Only the owner can call this function!");
      _;
    }
}
```


## Reserved Keywords
====================

These keywords are reserved in Solidity. They might become part of the syntax in the future:

`after`, `alias`, `apply`, `auto`, `byte`, `case`, `copyof`, `default`,
`define`, `final`, `implements`, `in`, `inline`, `let`, `macro`, `match`,
`mutable`, `null`, `of`, `partial`, `promise`, `reference`, `relocatable`,
`sealed`, `sizeof`, `static`, `supports`, `switch`, `typedef`, `typeof`,
`var`.