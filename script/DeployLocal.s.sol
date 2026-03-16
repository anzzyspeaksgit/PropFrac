// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import {PropertyToken} from "../contracts/PropertyToken.sol";
import {PropertyManager} from "../contracts/PropertyManager.sol";
import {RentalDistributor} from "../contracts/RentalDistributor.sol";
import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract MockUSDC is ERC20 {
    constructor() ERC20("Mock USDC", "USDC") {
        _mint(msg.sender, 1_000_000 * 10 ** 18); // Mint 1M USDC to deployer
    }
}

contract DeployLocalScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        // Deploy Mock USDC
        MockUSDC paymentToken = new MockUSDC();

        // Deploy Core Contracts
        PropertyToken token = new PropertyToken("https://propfrac.app/api/properties/", false);
        PropertyManager manager = new PropertyManager(address(token), address(paymentToken));
        RentalDistributor distributor = new RentalDistributor(address(token), address(paymentToken));

        // Setup roles and permissions
        token.grantRole(token.MINTER_ROLE(), address(manager));
        token.setApprovalForAll(address(manager), true);
        token.setApprovalForAll(address(distributor), true);

        // Optional: Create a test property
        token.createProperty(1, 100); // Property ID 1, 100 fractions
        manager.createListing(1, 50, 1000 * 10 ** 18); // List 50 fractions at 1000 USDC each

        vm.stopBroadcast();

        // Log outputs for frontend
        console.log("Mock USDC:", address(paymentToken));
        console.log("PropertyToken:", address(token));
        console.log("PropertyManager:", address(manager));
        console.log("RentalDistributor:", address(distributor));
    }
}
