// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {PropertyToken} from "../contracts/PropertyToken.sol";
import {PropertyManager} from "../contracts/PropertyManager.sol";
import {RentalDistributor} from "../contracts/RentalDistributor.sol";
import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract MockUSDC is ERC20 {
    constructor() ERC20("Mock USDC", "USDC") {}
    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}

contract PropFracTest is Test {
    PropertyToken public propertyToken;
    PropertyManager public propertyManager;
    RentalDistributor public rentalDistributor;
    MockUSDC public mockUSDC;

    address public owner = address(1);
    address public buyer = address(2);

    function setUp() public {
        vm.startPrank(owner);
        mockUSDC = new MockUSDC();
        propertyToken = new PropertyToken("ipfs://baseuri/");
        propertyManager = new PropertyManager(address(propertyToken), address(mockUSDC));
        rentalDistributor = new RentalDistributor(address(propertyToken), address(mockUSDC));

        // Create a property
        propertyToken.createProperty(1, 100);
        
        // Approve manager to list
        propertyToken.setApprovalForAll(address(propertyManager), true);
        
        // Transfer fractions to manager for listing
        propertyToken.safeTransferFrom(owner, address(propertyManager), 1, 50, "");
        
        // List property
        propertyManager.createListing(1, 50, 100 * 10**18);
        vm.stopPrank();

        // Mint mock USDC to buyer
        mockUSDC.mint(buyer, 1000 * 10**18);
    }

    function testPropertyCreation() public {
        assertEq(propertyToken.propertyExists(1), true);
        assertEq(propertyToken.propertySupply(1), 100);
    }

    function testBuyFractions() public {
        vm.startPrank(buyer);
        mockUSDC.approve(address(propertyManager), 1000 * 10**18);
        propertyManager.buyFractions(1, 10);
        vm.stopPrank();

        assertEq(propertyToken.balanceOf(buyer, 1), 10);
        assertEq(mockUSDC.balanceOf(address(propertyManager)), 1000 * 10**18);
    }

    function testYieldDistribution() public {
        // Buyer buys 10 fractions
        vm.startPrank(buyer);
        mockUSDC.approve(address(propertyManager), 1000 * 10**18);
        propertyManager.buyFractions(1, 10);
        vm.stopPrank();

        // Owner distributes yield
        vm.startPrank(owner);
        mockUSDC.mint(owner, 1000 * 10**18);
        mockUSDC.approve(address(rentalDistributor), 1000 * 10**18);
        rentalDistributor.distributeYield(1, 100 * 10**18);
        vm.stopPrank();

        uint256 claimable = rentalDistributor.getUnclaimedYield(buyer, 1);
        assertEq(claimable, 10 * 10**18); // 100 total supply -> 1 per fraction -> 10 claimable for 10 fractions

        // Claim
        vm.startPrank(buyer);
        rentalDistributor.claimYield(1);
        vm.stopPrank();
        
        assertEq(mockUSDC.balanceOf(buyer), 10 * 10**18);
    }
}
