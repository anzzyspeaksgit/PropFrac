# PropFrac Architecture

## Overview
PropFrac is a fractional real estate investment platform. Real estate properties are tokenized using the ERC1155 standard, allowing multiple users to own a fraction of the same underlying asset.

## Smart Contracts

### 1. PropertyToken (ERC1155)
- Manages the lifecycle and minting of fractional property tokens.
- Inherits `ERC1155` from OpenZeppelin.
- Key Functions:
  - `createProperty(uint256 propertyId, uint256 totalFractions)`: Initializes a property with a total supply.
  - Role-based minter access.
  - Pausable functionality for emergencies.

### 2. PropertyManager
- Handles listing of property fractions and selling them to investors.
- Key Functions:
  - `createListing(uint256 propertyId, uint256 fractions, uint256 pricePerFraction)`: Owner lists fractions for sale.
  - `buyFractions(uint256 propertyId, uint256 amount)`: Investors buy fractions using stablecoin.

### 3. RentalDistributor
- Manages rental yield distribution to token holders.
- Key Functions:
  - `distributeYield(uint256 propertyId, uint256 amount)`: Distributes a total yield amount evenly across all fractions.
  - `claimYield(uint256 propertyId)`: Investors claim their share of the rental yield.

## Frontend (Next.js)
The frontend will provide a marketplace UI to browse properties, a portfolio dashboard, and investment workflows utilizing viem and wagmi for on-chain interactions.
