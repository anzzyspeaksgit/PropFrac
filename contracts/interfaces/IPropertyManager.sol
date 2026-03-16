// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC1155Receiver} from "openzeppelin-contracts/contracts/token/ERC1155/IERC1155Receiver.sol";

interface IPropertyManager is IERC1155Receiver {
    event ListingCreated(uint256 indexed propertyId, uint256 fractions, uint256 pricePerFraction);
    event FractionsPurchased(address indexed buyer, uint256 indexed propertyId, uint256 amount, uint256 cost);
    event ListingUpdated(uint256 indexed propertyId, bool active);
    event FundsWithdrawn(address indexed owner, uint256 amount);

    function createListing(uint256 propertyId, uint256 fractions, uint256 pricePerFraction) external;
    function buyFractions(uint256 propertyId, uint256 amount) external;
    function toggleListing(uint256 propertyId, bool active) external;
    function withdrawFunds(uint256 amount) external;

    function propertyToken() external view returns (address);
    function paymentToken() external view returns (address);
}
