# IPropertyToken
[Git Source](https://github.com/anzzyspeaksgit/PropFrac/blob/1e9072dde7816405151232af295fc17546b5f132/contracts/interfaces/IPropertyToken.sol)

**Inherits:**
IERC1155


## Functions
### propertySupply


```solidity
function propertySupply(uint256 propertyId) external view returns (uint256);
```

### propertyExists


```solidity
function propertyExists(uint256 propertyId) external view returns (bool);
```

### propertyValuation


```solidity
function propertyValuation(uint256 propertyId) external view returns (uint256);
```

### isWhitelisted


```solidity
function isWhitelisted(address account) external view returns (bool);
```

### requiresKYC


```solidity
function requiresKYC() external view returns (bool);
```

### createProperty


```solidity
function createProperty(uint256 propertyId, uint256 totalFractions) external;
```

### mint


```solidity
function mint(address to, uint256 id, uint256 amount, bytes memory data) external;
```

### mintBatch


```solidity
function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data) external;
```

### updatePropertyValuation


```solidity
function updatePropertyValuation(uint256 propertyId, uint256 newValuation) external;
```

### setWhitelist


```solidity
function setWhitelist(address account, bool status) external;
```

### setRequiresKYC


```solidity
function setRequiresKYC(bool required) external;
```

### setBaseURI


```solidity
function setBaseURI(string memory newuri) external;
```

### setDefaultRoyalty


```solidity
function setDefaultRoyalty(address receiver, uint96 feeNumerator) external;
```

### setTokenRoyalty


```solidity
function setTokenRoyalty(uint256 propertyId, address receiver, uint96 feeNumerator) external;
```

### pause


```solidity
function pause() external;
```

### unpause


```solidity
function unpause() external;
```

## Events
### PropertyCreated

```solidity
event PropertyCreated(uint256 indexed propertyId, uint256 totalFractions);
```

### PropertyValuationUpdated

```solidity
event PropertyValuationUpdated(uint256 indexed propertyId, uint256 oldValuation, uint256 newValuation);
```

### WhitelistUpdated

```solidity
event WhitelistUpdated(address indexed account, bool status);
```

### KYCRequirementChanged

```solidity
event KYCRequirementChanged(bool required);
```

