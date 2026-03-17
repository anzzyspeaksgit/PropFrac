// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { ERC1155 } from "openzeppelin-contracts/contracts/token/ERC1155/ERC1155.sol";
import { AccessControl } from "openzeppelin-contracts/contracts/access/AccessControl.sol";
import { Pausable } from "openzeppelin-contracts/contracts/utils/Pausable.sol";
import { Strings } from "openzeppelin-contracts/contracts/utils/Strings.sol";

/**
 * @title PropertyToken
 * @dev ERC1155 token representing fractional ownership of real estate properties.
 */
contract PropertyToken is ERC1155, AccessControl, Pausable {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant ORACLE_ROLE = keccak256("ORACLE_ROLE");

    // KYC/AML compliance (Aligned with BaseRWA pattern)
    mapping(address => bool) public isWhitelisted;
    bool public requiresKYC;

    // Mapping from property ID to total fractions (supply)
    mapping(uint256 => uint256) public propertySupply;
    // Mapping from property ID to whether it exists
    mapping(uint256 => bool) public propertyExists;
    // Mapping from property ID to valuation (USD with 18 decimals)
    mapping(uint256 => uint256) public propertyValuation;

    // Base URI for metadata
    string private _baseURI;

    event PropertyCreated(uint256 indexed propertyId, uint256 totalFractions);
    event PropertyValuationUpdated(uint256 indexed propertyId, uint256 oldValuation, uint256 newValuation);
    event WhitelistUpdated(address indexed account, bool status);
    event KYCRequirementChanged(bool required);

    constructor(string memory baseURI, bool _requiresKYC) ERC1155("") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
        _grantRole(ORACLE_ROLE, msg.sender);
        _baseURI = baseURI;
        requiresKYC = _requiresKYC;
    }

    function updatePropertyValuation(uint256 propertyId, uint256 newValuation) external onlyRole(ORACLE_ROLE) {
        require(propertyExists[propertyId], "PropertyToken: Property does not exist");
        uint256 oldValuation = propertyValuation[propertyId];
        propertyValuation[propertyId] = newValuation;
        emit PropertyValuationUpdated(propertyId, oldValuation, newValuation);
    }

    function setWhitelist(address account, bool status) external onlyRole(DEFAULT_ADMIN_ROLE) {
        isWhitelisted[account] = status;
        emit WhitelistUpdated(account, status);
    }

    function setRequiresKYC(bool required) external onlyRole(DEFAULT_ADMIN_ROLE) {
        requiresKYC = required;
        emit KYCRequirementChanged(required);
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

    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    )
        external
        onlyRole(MINTER_ROLE)
    {
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

    function _update(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory values
    )
        internal
        virtual
        override
        whenNotPaused
    {
        if (requiresKYC && from != address(0) && to != address(0)) {
            require(isWhitelisted[from] && isWhitelisted[to], "KYC required for transfer");
        }
        super._update(from, to, ids, values);
    }

    // Override required by Solidity for multiple inheritance
    function supportsInterface(bytes4 interfaceId) public view override(ERC1155, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
