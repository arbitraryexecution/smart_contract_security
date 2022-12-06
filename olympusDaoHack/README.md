# Olympus DAO Attack

## Background

On October 21, 2022 the Olympus DAO was exploited for approximately 300K of OHM tokens. After analysis, it was found that the Olympus DAO contract exposes a `redeem` function which contains an exploitable vulnerability.

## Exercise

1. Identify the vulnerability in the Olympus DAO contract's `redeem` function

2. Write a solidity contract which will exploit the located vulnerability and transfer all OHM tokens to the callers account.  NOTE: The exploit contract has already been created `contracts/AttackContract.sol`

3. Verify that the exploit contract works by running the provided test script `node scripts/test-exploit.js`

### Vulnerable Contract Information

* Source: https://github.com/Bond-Protocol/bond-contracts/blob/b2f34387674c582eb94f991dd0134bd421190f30/src/BondFixedExpiryTeller.sol#L137-L142
```solidity
    function redeem(ERC20BondToken token_, uint256 amount_) external override nonReentrant {
        if (uint48(block.timestamp) < token_.expiry())
            revert Teller_TokenNotMatured(token_.expiry());
        token_.burn(msg.sender, amount_);
        token_.underlying().transfer(msg.sender, amount_);
    }
```

* Olympus DAO Contract Address: `0x007fe7c498a2cf30971ad8f2cbc36bd14ac51156`
* OHM Token Contract Address: `0x64aa3364F17a4D01c6f1751Fd97C2BD3D7e7f1D5`

