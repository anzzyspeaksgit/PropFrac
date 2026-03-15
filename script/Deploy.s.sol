// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import {PropertyToken} from "../contracts/PropertyToken.sol";
import {PropertyManager} from "../contracts/PropertyManager.sol";
import {RentalDistributor} from "../contracts/RentalDistributor.sol";

contract DeployScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address paymentToken = vm.envAddress("PAYMENT_TOKEN"); // address of USDC or MockUSDC

        vm.startBroadcast(deployerPrivateKey);

        PropertyToken token = new PropertyToken("https://propfrac.app/api/properties/");
        PropertyManager manager = new PropertyManager(address(token), paymentToken);
        RentalDistributor distributor = new RentalDistributor(address(token), paymentToken);

        // Grant minter role to manager (optional but useful if manager needs to mint later)
        // Set approval for manager to list properties
        token.setApprovalForAll(address(manager), true);

        vm.stopBroadcast();
    }
}
