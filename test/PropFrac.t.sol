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
    MockUSDC public mockUsdc;

    address public owner = address(1);
    address public buyer = address(2);
    address public buyer2 = address(3);

    function setUp() public {
        vm.startPrank(owner);
        mockUsdc = new MockUSDC();
        propertyToken = new PropertyToken("ipfs://baseuri/", false);
        propertyManager = new PropertyManager(address(propertyToken), address(mockUsdc));
        rentalDistributor = new RentalDistributor(address(propertyToken), address(mockUsdc));

        // Create a property
        propertyToken.createProperty(1, 100);

        // Approve manager to list
        propertyToken.setApprovalForAll(address(propertyManager), true);

        // Transfer fractions to manager for listing
        propertyToken.safeTransferFrom(owner, address(propertyManager), 1, 50, "");

        // List property
        propertyManager.createListing(1, 50, 100 * 10 ** 18);
        vm.stopPrank();

        // Mint mock USDC to buyers
        mockUsdc.mint(buyer, 1000 * 10 ** 18);
        mockUsdc.mint(buyer2, 1000 * 10 ** 18);
    }

    function testPropertyCreation() public view {
        assertEq(propertyToken.propertyExists(1), true);
        assertEq(propertyToken.propertySupply(1), 100);
    }

    function testSetBaseURI() public {
        vm.prank(owner);
        propertyToken.setBaseURI("ipfs://newbase/");
        assertEq(propertyToken.uri(1), "ipfs://newbase/1.json");
    }

    function testMintBatch() public {
        vm.startPrank(owner);
        propertyToken.createProperty(2, 200);

        uint256[] memory ids = new uint256[](2);
        ids[0] = 1;
        ids[1] = 2;

        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 10;
        amounts[1] = 20;

        propertyToken.mintBatch(buyer, ids, amounts, "");
        vm.stopPrank();

        assertEq(propertyToken.balanceOf(buyer, 1), 10);
        assertEq(propertyToken.balanceOf(buyer, 2), 20);
    }

    function testBuyFractions() public {
        vm.startPrank(buyer);
        mockUsdc.approve(address(propertyManager), 1000 * 10 ** 18);
        propertyManager.buyFractions(1, 10);
        vm.stopPrank();

        assertEq(propertyToken.balanceOf(buyer, 1), 10);
        assertEq(mockUsdc.balanceOf(address(propertyManager)), 1000 * 10 ** 18);
    }

    function testToggleListing() public {
        vm.startPrank(owner);
        propertyManager.toggleListing(1, false);

        (uint256 id, uint256 avail, uint256 price, bool active) = propertyManager.listings(1);
        assertEq(active, false);
        vm.stopPrank();
    }

    function testWithdrawFunds() public {
        vm.startPrank(buyer);
        mockUsdc.approve(address(propertyManager), 1000 * 10 ** 18);
        propertyManager.buyFractions(1, 10); // costs 1000 USDC
        vm.stopPrank();

        vm.startPrank(owner);
        propertyManager.withdrawFunds(1000 * 10 ** 18);
        vm.stopPrank();

        assertEq(mockUsdc.balanceOf(owner), 1000 * 10 ** 18);
    }

    function testYieldDistribution() public {
        // Buyer buys 10 fractions
        vm.startPrank(buyer);
        mockUsdc.approve(address(propertyManager), 1000 * 10 ** 18);
        propertyManager.buyFractions(1, 10);
        vm.stopPrank();

        // Owner distributes yield
        vm.startPrank(owner);
        mockUsdc.mint(owner, 1000 * 10 ** 18);
        mockUsdc.approve(address(rentalDistributor), 1000 * 10 ** 18);
        rentalDistributor.distributeYield(1, 100 * 10 ** 18);
        vm.stopPrank();

        uint256 claimable = rentalDistributor.getUnclaimedYield(buyer, 1);
        assertEq(claimable, 10 * 10 ** 18); // 100 total supply -> 1 per fraction -> 10 claimable for 10 fractions

        // Claim
        vm.startPrank(buyer);
        rentalDistributor.claimYield(1);
        vm.stopPrank();

        assertEq(mockUsdc.balanceOf(buyer), 10 * 10 ** 18);
    }

    function testPauseUnpause() public {
        vm.startPrank(owner);
        propertyToken.pause();
        vm.expectRevert();
        propertyToken.createProperty(3, 100);

        propertyToken.unpause();
        propertyToken.createProperty(3, 100);
        vm.stopPrank();
        assertEq(propertyToken.propertyExists(3), true);
    }
}
