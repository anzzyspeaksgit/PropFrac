# PropertyToken
[Git Source](https://github.com/anzzyspeaksgit/PropFrac/blob/1e9072dde7816405151232af295fc17546b5f132/contracts/PropertyToken.sol)

**Inherits:**
ERC1155, AccessControl, Pausable, ERC2981

**Title:**
PropertyToken

ERC1155 token representing fractional ownership of real estate properties.


## State Variables
### MINTER_ROLE

```solidity
bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE")
```


### PAUSER_ROLE

```solidity
bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE")
```


### ORACLE_ROLE

```solidity
bytes32 public constant ORACLE_ROLE = keccak256("ORACLE_ROLE")
```


### isWhitelisted

```solidity
mapping(address => bool) public isWhitelisted
```


### requiresKYC

```solidity
bool public requiresKYC
```


### propertySupply

```solidity
mapping(uint256 => uint256) public propertySupply
```


### propertyExists

```solidity
mapping(uint256 => bool) public propertyExists
```


### propertyValuation

```solidity
mapping(uint256 => uint256) public propertyValuation
```


### _baseURI

```solidity
string private _baseURI
```


## Functions
### constructor


```solidity
constructor(string memory baseURI, bool _requiresKYC) ERC1155("");
```

### setDefaultRoyalty


```solidity
function setDefaultRoyalty(address receiver, uint96 feeNumerator) external onlyRole(DEFAULT_ADMIN_ROLE);
```

### setTokenRoyalty


```solidity
function setTokenRoyalty(
    uint256 propertyId,
    address receiver,
    uint96 feeNumerator
)
    external
    onlyRole(DEFAULT_ADMIN_ROLE);
```

### updatePropertyValuation


```solidity
function updatePropertyValuation(uint256 propertyId, uint256 newValuation) external onlyRole(ORACLE_ROLE);
```

### setWhitelist


```solidity
function setWhitelist(address account, bool status) external onlyRole(DEFAULT_ADMIN_ROLE);
```

### setRequiresKYC


```solidity
function setRequiresKYC(bool required) external onlyRole(DEFAULT_ADMIN_ROLE);
```

### setBaseURI


```solidity
function setBaseURI(string memory newuri) external onlyRole(DEFAULT_ADMIN_ROLE);
```

### uri


```solidity
function uri(uint256 propertyId) public view override returns (string memory);
```

### createProperty


```solidity
function createProperty(uint256 propertyId, uint256 totalFractions) external onlyRole(MINTER_ROLE);
```

### mint


```solidity
function mint(address to, uint256 id, uint256 amount, bytes memory data) external onlyRole(MINTER_ROLE);
```

### mintBatch


```solidity
function mintBatch(
    address to,
    uint256[] memory ids,
    uint256[] memory amounts,
    bytes memory data
)
    external
    onlyRole(MINTER_ROLE);
```

### pause


```solidity
function pause() external onlyRole(PAUSER_ROLE);
```

### unpause


```solidity
function unpause() external onlyRole(PAUSER_ROLE);
```

### _update


```solidity
function _update(
    address from,
    address to,
    uint256[] memory ids,
    uint256[] memory values
)
    internal
    virtual
    override
    whenNotPaused;
```

### supportsInterface


```solidity
function supportsInterface(bytes4 interfaceId)
    public
    view
    override(ERC1155, AccessControl, ERC2981)
    returns (bool);
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

