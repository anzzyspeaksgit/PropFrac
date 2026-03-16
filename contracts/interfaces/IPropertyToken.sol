// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IERC1155} from "openzeppelin-contracts/contracts/token/ERC1155/IERC1155.sol";

interface IPropertyToken is IERC1155 {
    event PropertyCreated(uint256 indexed propertyId, uint256 totalFractions);
    event WhitelistUpdated(address indexed account, bool status);
    event KYCRequirementChanged(bool required);

    function propertySupply(uint256 propertyId) external view returns (uint256);
    function propertyExists(uint256 propertyId) external view returns (bool);
    function isWhitelisted(address account) external view returns (bool);
    function requiresKYC() external view returns (bool);

    function createProperty(uint256 propertyId, uint256 totalFractions) external;
    function mint(address to, uint256 id, uint256 amount, bytes memory data) external;
    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data) external;
    
    function setWhitelist(address account, bool status) external;
    function setRequiresKYC(bool required) external;
    function setBaseURI(string memory newuri) external;

    function pause() external;
    function unpause() external;
}
