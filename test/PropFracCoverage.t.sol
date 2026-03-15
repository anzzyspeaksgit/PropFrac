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

contract PropFracCoverageTest is Test {
    PropertyToken public propertyToken;
    PropertyManager public propertyManager;
    RentalDistributor public rentalDistributor;
    MockUSDC public mockUsdc;

    address public owner = address(1);
    address public buyer = address(2);

    function setUp() public {
        vm.startPrank(owner);
        mockUsdc = new MockUSDC();
        propertyToken = new PropertyToken("ipfs://baseuri/");
        propertyManager = new PropertyManager(address(propertyToken), address(mockUsdc));
        rentalDistributor = new RentalDistributor(address(propertyToken), address(mockUsdc));
        vm.stopPrank();
    }

    function testPropertyExistsRevert() public {
        vm.startPrank(owner);
        propertyToken.createProperty(1, 100);
        
        vm.expectRevert("PropertyToken: Property already exists");
        propertyToken.createProperty(1, 100);
        vm.stopPrank();
    }
    
    function testUriRevert() public {
        vm.expectRevert("PropertyToken: URI query for nonexistent property");
        propertyToken.uri(999);
    }
    
    function testMintRevert() public {
        vm.startPrank(owner);
        vm.expectRevert("PropertyToken: Property does not exist");
        propertyToken.mint(buyer, 999, 10, "");
        vm.stopPrank();
    }
    
    function testMintBatchRevert() public {
        vm.startPrank(owner);
        uint256[] memory ids = new uint256[](1);
        ids[0] = 999;
        uint256[] memory amounts = new uint256[](1);
        amounts[0] = 10;
        
        vm.expectRevert("PropertyToken: Property does not exist");
        propertyToken.mintBatch(buyer, ids, amounts, "");
        vm.stopPrank();
    }
    
    function testSupportsInterface() public view {
        bool supportsERC1155 = propertyToken.supportsInterface(0xd9b67a26); // ERC1155
        assertEq(supportsERC1155, true);
    }
    
    function testManagerCreateListingReverts() public {
        vm.startPrank(owner);
        propertyToken.createProperty(1, 100);
        
        vm.expectRevert("Not enough fractions to list");
        propertyManager.createListing(1, 150, 1000);
        
        propertyToken.setApprovalForAll(address(propertyManager), true);
        propertyToken.safeTransferFrom(owner, address(propertyManager), 1, 50, "");
        
        vm.expectRevert("Price must be > 0");
        propertyManager.createListing(1, 50, 0);
        vm.stopPrank();
    }
    
    function testBuyFractionsReverts() public {
        vm.startPrank(owner);
        propertyToken.createProperty(1, 100);
        propertyToken.safeTransferFrom(owner, address(propertyManager), 1, 50, "");
        propertyManager.createListing(1, 50, 100);
        vm.stopPrank();
        
        vm.startPrank(buyer);
        vm.expectRevert("Not enough fractions available");
        propertyManager.buyFractions(1, 60);
        
        vm.expectRevert("Amount must be > 0");
        propertyManager.buyFractions(1, 0);
        vm.stopPrank();
    }
    
    function testBuyFractionsInactiveRevert() public {
        vm.startPrank(owner);
        propertyToken.createProperty(1, 100);
        propertyToken.safeTransferFrom(owner, address(propertyManager), 1, 50, "");
        propertyManager.createListing(1, 50, 100);
        propertyManager.toggleListing(1, false);
        vm.stopPrank();
        
        vm.startPrank(buyer);
        vm.expectRevert("Listing not active");
        propertyManager.buyFractions(1, 10);
        vm.stopPrank();
    }
    
    function testManagerOnReceived() public {
        bytes4 single = propertyManager.onERC1155Received(address(0), address(0), 0, 0, "");
        assertEq(single, propertyManager.onERC1155Received.selector);
        
        uint256[] memory ids = new uint256[](0);
        uint256[] memory amounts = new uint256[](0);
        bytes4 batch = propertyManager.onERC1155BatchReceived(address(0), address(0), ids, amounts, "");
        assertEq(batch, propertyManager.onERC1155BatchReceived.selector);
    }
}
