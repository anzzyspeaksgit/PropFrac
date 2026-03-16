-include .env

.PHONY: all test clean deploy-local deploy-testnet coverage format lint

all: clean format build test

# Clean the repo
clean:
	forge clean

# Build the contracts
build:
	forge build

# Run tests
test:
	forge test -vv

# Format code
format:
	forge fmt

# Get test coverage
coverage:
	forge coverage

# Local deployment with Anvil
deploy-local:
	@echo "Deploying locally..."
	forge script script/DeployLocal.s.sol:DeployLocalScript --fork-url http://localhost:8545 --broadcast -vvvv

# Testnet deployment (requires PRIVATE_KEY and BNB_TESTNET_RPC in .env)
deploy-testnet:
	@echo "Deploying to BNB Testnet..."
	forge script script/Deploy.s.sol:DeployScript --rpc-url $(BNB_TESTNET_RPC) --private-key $(PRIVATE_KEY) --broadcast --verify --legacy
