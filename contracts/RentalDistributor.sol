// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {PropertyToken} from "./PropertyToken.sol";
import {ReentrancyGuard} from "openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";

/**
 * @title RentalDistributor
 * @dev Handles distribution of rental yields to fractional property owners.
 */
contract RentalDistributor is ReentrancyGuard, Ownable {
    using SafeERC20 for IERC20;

    PropertyToken public propertyToken;
    IERC20 public paymentToken; // e.g., USDC or another stablecoin

    struct RentalDistribution {
        uint256 propertyId;
        uint256 totalAmount;
        uint256 timestamp;
        uint256 amountPerFraction;
    }

    // Mapping from property ID to a list of distributions
    mapping(uint256 => RentalDistribution[]) public distributions;

    // Mapping from user address to property ID to last claimed distribution index
    mapping(address => mapping(uint256 => uint256)) public lastClaimedDistribution;

    event YieldDistributed(uint256 indexed propertyId, uint256 totalAmount, uint256 amountPerFraction);
    event YieldClaimed(address indexed user, uint256 indexed propertyId, uint256 amount);

    constructor(address _propertyToken, address _paymentToken) Ownable(msg.sender) {
        require(_propertyToken != address(0), "Invalid token address");
        require(_paymentToken != address(0), "Invalid payment token address");
        propertyToken = PropertyToken(_propertyToken);
        paymentToken = IERC20(_paymentToken);
    }

    function distributeYield(uint256 propertyId, uint256 amount) external nonReentrant onlyOwner {
        require(propertyToken.propertyExists(propertyId), "Property does not exist");
        uint256 totalFractions = propertyToken.propertySupply(propertyId);
        require(totalFractions > 0, "No fractions exist");
        require(amount > 0, "Amount must be > 0");

        uint256 amountPerFraction = amount / totalFractions;
        require(amountPerFraction > 0, "Amount too small");

        distributions[propertyId].push(RentalDistribution({
            propertyId: propertyId,
            totalAmount: amount,
            timestamp: block.timestamp,
            amountPerFraction: amountPerFraction
        }));

        // Transfer funds from owner to this contract for distribution
        paymentToken.safeTransferFrom(msg.sender, address(this), amount);

        emit YieldDistributed(propertyId, amount, amountPerFraction);
    }

    function claimYield(uint256 propertyId) external nonReentrant {
        uint256 userFractions = propertyToken.balanceOf(msg.sender, propertyId);
        require(userFractions > 0, "No fractions owned");

        uint256 distributionsCount = distributions[propertyId].length;
        uint256 startIndex = lastClaimedDistribution[msg.sender][propertyId];

        require(startIndex < distributionsCount, "No new yield to claim");

        uint256 totalClaim = 0;
        for (uint256 i = startIndex; i < distributionsCount; i++) {
            totalClaim += distributions[propertyId][i].amountPerFraction * userFractions;
        }

        lastClaimedDistribution[msg.sender][propertyId] = distributionsCount;

        if (totalClaim > 0) {
            paymentToken.safeTransfer(msg.sender, totalClaim);
            emit YieldClaimed(msg.sender, propertyId, totalClaim);
        }
    }

    function getUnclaimedYield(address user, uint256 propertyId) external view returns (uint256) {
        uint256 userFractions = propertyToken.balanceOf(user, propertyId);
        if (userFractions == 0) return 0;

        uint256 distributionsCount = distributions[propertyId].length;
        uint256 startIndex = lastClaimedDistribution[user][propertyId];

        uint256 totalClaim = 0;
        for (uint256 i = startIndex; i < distributionsCount; i++) {
            totalClaim += distributions[propertyId][i].amountPerFraction * userFractions;
        }
        return totalClaim;
    }
}
