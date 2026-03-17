# IPropertyManager
[Git Source](https://github.com/anzzyspeaksgit/PropFrac/blob/1e9072dde7816405151232af295fc17546b5f132/contracts/interfaces/IPropertyManager.sol)

**Inherits:**
IERC1155Receiver


## Functions
### createListing


```solidity
function createListing(uint256 propertyId, uint256 fractions, uint256 pricePerFraction) external;
```

### buyFractions


```solidity
function buyFractions(uint256 propertyId, uint256 amount) external;
```

### toggleListing


```solidity
function toggleListing(uint256 propertyId, bool active) external;
```

### withdrawFunds


```solidity
function withdrawFunds(uint256 amount) external;
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
### ListingCreated

```solidity
event ListingCreated(uint256 indexed propertyId, uint256 fractions, uint256 pricePerFraction);
```

### FractionsPurchased

```solidity
event FractionsPurchased(address indexed buyer, uint256 indexed propertyId, uint256 amount, uint256 cost);
```

### ListingUpdated

```solidity
event ListingUpdated(uint256 indexed propertyId, bool active);
```

### FundsWithdrawn

```solidity
event FundsWithdrawn(address indexed owner, uint256 amount);
```

