# PropFrac Smart Contracts

These are the core smart contracts for the PropFrac fractional real estate protocol.

## Contracts Overview

1. **PropertyToken.sol**
   - Implements ERC1155 for tokenizing multiple real estate properties.
   - Includes KYC compliance aligned with `BaseRWA` architecture (`isWhitelisted`, `requiresKYC`).
   - Minter and Pauser roles managed via `AccessControl`.

2. **PropertyManager.sol**
   - Handles the listing and primary market sales of property fractions.
   - Users can purchase fractions utilizing an approved ERC20 stablecoin (e.g., USDC).

3. **RentalDistributor.sol**
   - Manages the distribution of rental yields.
   - Yield distributions are proportional to the amount of fractions a user holds.
   - Implements a claims mechanism tracking `lastClaimedDistribution` per user per property.

## Development

```shell
# Install dependencies
forge install

# Compile contracts
forge build

# Run tests
forge test

# Check coverage
forge coverage
```

## Deployment
Scripts are provided in `script/`:
- `Deploy.s.sol`: Deploys to testnets (e.g., BNB Testnet).
- `DeployLocal.s.sol`: Deploys a mock stablecoin and the core contracts, initializing a test property, designed specifically to accelerate local frontend testing.
