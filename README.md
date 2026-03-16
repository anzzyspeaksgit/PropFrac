# PropFrac

PropFrac is a fractional real estate investment platform built on the BNB Chain. It tokenizes high-value real estate into accessible ERC1155 fractions, enabling investors to own a piece of premium properties and earn proportional rental yield.

## Overview

- **Contracts:** Foundry, Solidity 0.8.20+, OpenZeppelin
- **Frontend:** Next.js 14, TailwindCSS, shadcn/ui, wagmi, viem, RainbowKit
- **Network:** BNB Testnet

## Project Structure

- `/contracts/`: Core smart contracts (`PropertyToken`, `PropertyManager`, `RentalDistributor`).
- `/test/`: Comprehensive Forge tests (>95% coverage).
- `/script/`: Deployment scripts for local and testnet environments.
- `/frontend/`: Next.js DApp for browsing and investing in properties.
- `/docs/`: Protocol architecture and documentation.

## Smart Contracts

The contracts phase is fully complete:
- `PropertyToken` (ERC1155): Includes robust role-based access control and KYC/AML compliance features.
- `PropertyManager`: Facilitates the primary listing and sale of property fractions.
- `RentalDistributor`: Distributes USDC rental yields proportionally to fractional owners.

## Getting Started

### Smart Contracts
```bash
make build
make test
```

### Frontend
```bash
cd frontend
npm install
npm run dev
```
