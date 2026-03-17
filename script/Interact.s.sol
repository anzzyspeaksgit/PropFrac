// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import { IPropertyManager } from "../contracts/interfaces/IPropertyManager.sol";
import { IERC20 } from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract BuyFractionsScript is Script {
    function run() external {
        uint256 privateKey = vm.envUint("PRIVATE_KEY");
        address managerAddr = vm.envAddress("MANAGER_ADDRESS");
        address paymentAddr = vm.envAddress("PAYMENT_TOKEN");
        uint256 propertyId = vm.envOr("PROPERTY_ID", uint256(1));
        uint256 amount = vm.envOr("AMOUNT", uint256(10));

        IPropertyManager manager = IPropertyManager(managerAddr);
        IERC20 paymentToken = IERC20(paymentAddr);

        vm.startBroadcast(privateKey);

        // Assume caller already has the payment token; approve the manager
        // E.g. $1000 per fraction * amount (needs precise decimals matching)
        // Hardcoding a high enough approval for test script purposes
        paymentToken.approve(managerAddr, type(uint256).max);

        // Buy the specified amount of fractions
        manager.buyFractions(propertyId, amount);

        vm.stopBroadcast();

        console.log("Successfully bought %s fractions of property %s", amount, propertyId);
    }
}
