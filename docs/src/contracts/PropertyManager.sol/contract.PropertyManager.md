# PropertyManager
[Git Source](https://github.com/anzzyspeaksgit/PropFrac/blob/1e9072dde7816405151232af295fc17546b5f132/contracts/PropertyManager.sol)

**Inherits:**
ReentrancyGuard, Ownable, Pausable

**Title:**
PropertyManager

Handles property listings and fractional token sales.


## State Variables
### propertyToken

```solidity
PropertyToken public propertyToken
```


### paymentToken

```solidity
IERC20 public paymentToken
```


### listings

```solidity
mapping(uint256 => Listing) public listings
```


## Functions
### constructor


```solidity
constructor(address _propertyToken, address _paymentToken) Ownable(msg.sender);
```

### createListing


```solidity
function createListing(
    uint256 propertyId,
    uint256 fractions,
    uint256 pricePerFraction
)
    external
    onlyOwner
    whenNotPaused;
```

### buyFractions


```solidity
function buyFractions(uint256 propertyId, uint256 amount) external nonReentrant whenNotPaused;
```

### toggleListing


```solidity
function toggleListing(uint256 propertyId, bool active) external onlyOwner;
```

### withdrawFunds


```solidity
function withdrawFunds(uint256 amount) external onlyOwner;
```

### pause


```solidity
function pause() external onlyOwner;
```

### unpause


```solidity
function unpause() external onlyOwner;
```

### onERC1155Received


```solidity
function onERC1155Received(address, address, uint256, uint256, bytes calldata) external pure returns (bytes4);
```

### onERC1155BatchReceived


```solidity
function onERC1155BatchReceived(
    address,
    address,
    uint256[] calldata,
    uint256[] calldata,
    bytes calldata
)
    external
    pure
    returns (bytes4);
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

## Structs
### Listing

```solidity
struct Listing {
    uint256 propertyId;
    uint256 fractionsAvailable;
    uint256 pricePerFraction;
    bool active;
}
```

