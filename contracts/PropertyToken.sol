// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC1155} from "openzeppelin-contracts/contracts/token/ERC1155/ERC1155.sol";
import {AccessControl} from "openzeppelin-contracts/contracts/access/AccessControl.sol";
import {Pausable} from "openzeppelin-contracts/contracts/utils/Pausable.sol";
import {Strings} from "openzeppelin-contracts/contracts/utils/Strings.sol";

/**
 * @title PropertyToken
 * @dev ERC1155 token representing fractional ownership of real estate properties.
 */
contract PropertyToken is ERC1155, AccessControl, Pausable {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");

    // Mapping from property ID to total fractions (supply)
    mapping(uint256 => uint256) public propertySupply;
    // Mapping from property ID to whether it exists
    mapping(uint256 => bool) public propertyExists;

    // Base URI for metadata
    string private _baseURI;

    event PropertyCreated(uint256 indexed propertyId, uint256 totalFractions);

    constructor(string memory baseURI) ERC1155("") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
        _baseURI = baseURI;
    }

    function setBaseURI(string memory newuri) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _baseURI = newuri;
    }

    function uri(uint256 propertyId) public view override returns (string memory) {
        require(propertyExists[propertyId], "PropertyToken: URI query for nonexistent property");
        return string(abi.encodePacked(_baseURI, Strings.toString(propertyId), ".json"));
    }

    function createProperty(uint256 propertyId, uint256 totalFractions) external onlyRole(MINTER_ROLE) {
        require(!propertyExists[propertyId], "PropertyToken: Property already exists");
        propertyExists[propertyId] = true;
        propertySupply[propertyId] = totalFractions;
        
        _mint(msg.sender, propertyId, totalFractions, "");
        emit PropertyCreated(propertyId, totalFractions);
    }

    function mint(address to, uint256 id, uint256 amount, bytes memory data) external onlyRole(MINTER_ROLE) {
        require(propertyExists[id], "PropertyToken: Property does not exist");
        _mint(to, id, amount, data);
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data) external onlyRole(MINTER_ROLE) {
        for (uint256 i = 0; i < ids.length; i++) {
            require(propertyExists[ids[i]], "PropertyToken: Property does not exist");
        }
        _mintBatch(to, ids, amounts, data);
    }

    function pause() external onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() external onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    // Override required by Solidity for multiple inheritance
    function supportsInterface(bytes4 interfaceId) public view override(ERC1155, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
