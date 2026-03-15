// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {PropertyToken} from "./PropertyToken.sol";
import {ReentrancyGuard} from "openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";

/**
 * @title PropertyManager
 * @dev Handles property listings and fractional token sales.
 */
contract PropertyManager is ReentrancyGuard, Ownable {
    using SafeERC20 for IERC20;

    PropertyToken public propertyToken;
    IERC20 public paymentToken; // e.g., USDC or another stablecoin

    struct Listing {
        uint256 propertyId;
        uint256 fractionsAvailable;
        uint256 pricePerFraction;
        bool active;
    }

    // Mapping from property ID to Listing
    mapping(uint256 => Listing) public listings;

    event ListingCreated(uint256 indexed propertyId, uint256 fractions, uint256 pricePerFraction);
    event FractionsPurchased(address indexed buyer, uint256 indexed propertyId, uint256 amount, uint256 cost);
    event ListingUpdated(uint256 indexed propertyId, bool active);
    event FundsWithdrawn(address indexed owner, uint256 amount);

    constructor(address _propertyToken, address _paymentToken) Ownable(msg.sender) {
        require(_propertyToken != address(0), "Invalid token address");
        require(_paymentToken != address(0), "Invalid payment token address");
        propertyToken = PropertyToken(_propertyToken);
        paymentToken = IERC20(_paymentToken);
    }

    function createListing(uint256 propertyId, uint256 fractions, uint256 pricePerFraction) external onlyOwner {
        require(propertyToken.balanceOf(address(this), propertyId) >= fractions, "Not enough fractions to list");
        require(pricePerFraction > 0, "Price must be > 0");

        listings[propertyId] = Listing({
            propertyId: propertyId,
            fractionsAvailable: fractions,
            pricePerFraction: pricePerFraction,
            active: true
        });

        emit ListingCreated(propertyId, fractions, pricePerFraction);
    }

    function buyFractions(uint256 propertyId, uint256 amount) external nonReentrant {
        Listing storage listing = listings[propertyId];
        require(listing.active, "Listing not active");
        require(listing.fractionsAvailable >= amount, "Not enough fractions available");
        require(amount > 0, "Amount must be > 0");

        uint256 totalCost = amount * listing.pricePerFraction;
        listing.fractionsAvailable -= amount;

        if (listing.fractionsAvailable == 0) {
            listing.active = false;
        }

        // Transfer payment from buyer to this contract
        paymentToken.safeTransferFrom(msg.sender, address(this), totalCost);

        // Transfer property fractions from this contract to buyer
        propertyToken.safeTransferFrom(address(this), msg.sender, propertyId, amount, "");

        emit FractionsPurchased(msg.sender, propertyId, amount, totalCost);
    }

    function toggleListing(uint256 propertyId, bool active) external onlyOwner {
        require(listings[propertyId].propertyId == propertyId, "Listing does not exist");
        listings[propertyId].active = active;
        emit ListingUpdated(propertyId, active);
    }

    function withdrawFunds(uint256 amount) external onlyOwner {
        require(amount <= paymentToken.balanceOf(address(this)), "Insufficient balance");
        paymentToken.safeTransfer(owner(), amount);
        emit FundsWithdrawn(owner(), amount);
    }

    // Required by ERC1155 receiver standard
    function onERC1155Received(address, address, uint256, uint256, bytes calldata) external pure returns (bytes4) {
        return this.onERC1155Received.selector;
    }
    
    function onERC1155BatchReceived(address, address, uint256[] calldata, uint256[] calldata, bytes calldata) external pure returns (bytes4) {
        return this.onERC1155BatchReceived.selector;
    }
}
