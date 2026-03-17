# IRentalDistributor
[Git Source](https://github.com/anzzyspeaksgit/PropFrac/blob/1e9072dde7816405151232af295fc17546b5f132/contracts/interfaces/IRentalDistributor.sol)


## Functions
### distributeYield


```solidity
function distributeYield(uint256 propertyId, uint256 amount) external;
```

### claimYield


```solidity
function claimYield(uint256 propertyId) external;
```

### getUnclaimedYield


```solidity
function getUnclaimedYield(address user, uint256 propertyId) external view returns (uint256);
```

### propertyToken


```solidity
function propertyToken() external view returns (address);
```

### paymentToken


```solidity
function paymentToken() external view returns (address);
```

## Events
### YieldDistributed

```solidity
event YieldDistributed(uint256 indexed propertyId, uint256 totalAmount, uint256 amountPerFraction);
```

### YieldClaimed

```solidity
event YieldClaimed(address indexed user, uint256 indexed propertyId, uint256 amount);
```

