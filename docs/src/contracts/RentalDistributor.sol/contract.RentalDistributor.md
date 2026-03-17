# RentalDistributor
[Git Source](https://github.com/anzzyspeaksgit/PropFrac/blob/1e9072dde7816405151232af295fc17546b5f132/contracts/RentalDistributor.sol)

**Inherits:**
ReentrancyGuard, Ownable, Pausable

**Title:**
RentalDistributor

Handles distribution of rental yields to fractional property owners.


## State Variables
### propertyToken

```solidity
PropertyToken public propertyToken
```


### paymentToken

```solidity
IERC20 public paymentToken
```


### distributions

```solidity
mapping(uint256 => RentalDistribution[]) public distributions
```


### lastClaimedDistribution

```solidity
mapping(address => mapping(uint256 => uint256)) public lastClaimedDistribution
```


## Functions
### constructor


```solidity
constructor(address _propertyToken, address _paymentToken) Ownable(msg.sender);
```

### distributeYield


```solidity
function distributeYield(uint256 propertyId, uint256 amount) external nonReentrant onlyOwner whenNotPaused;
```

### claimYield


```solidity
function claimYield(uint256 propertyId) external nonReentrant whenNotPaused;
```

### getUnclaimedYield


```solidity
function getUnclaimedYield(address user, uint256 propertyId) external view returns (uint256);
```

### emergencyWithdraw


```solidity
function emergencyWithdraw(uint256 amount) external onlyOwner;
```

### pause


```solidity
function pause() external onlyOwner;
```

### unpause


```solidity
function unpause() external onlyOwner;
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

## Structs
### RentalDistribution

```solidity
struct RentalDistribution {
    uint256 propertyId;
    uint256 totalAmount;
    uint256 timestamp;
    uint256 amountPerFraction;
}
```

