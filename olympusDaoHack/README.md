# Olympus DAO Attack

## Vulnerable Contract Info

* Source: https://github.com/Bond-Protocol/bond-contracts/blob/b2f34387674c582eb94f991dd0134bd421190f30/src/BondFixedExpiryTeller.sol#L137-L142

```solidity
    function redeem(ERC20BondToken token_, uint256 amount_) external override nonReentrant {
        if (uint48(block.timestamp) < token_.expiry())
            revert Teller_TokenNotMatured(token_.expiry());
        token_.burn(msg.sender, amount_);
        token_.underlying().transfer(msg.sender, amount_);
    }
```

* Address: `0x007fe7c498a2cf30971ad8f2cbc36bd14ac51156`