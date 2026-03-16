// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IRentalDistributor {
    event YieldDistributed(uint256 indexed propertyId, uint256 totalAmount, uint256 amountPerFraction);
    event YieldClaimed(address indexed user, uint256 indexed propertyId, uint256 amount);

    function distributeYield(uint256 propertyId, uint256 amount) external;
    function claimYield(uint256 propertyId) external;
    function getUnclaimedYield(address user, uint256 propertyId) external view returns (uint256);

    function propertyToken() external view returns (address);
    function paymentToken() external view returns (address);
}
