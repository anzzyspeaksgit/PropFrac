import { Address } from 'viem';
import PropertyTokenABI from '../abi/PropertyToken.json';
import PropertyManagerABI from '../abi/PropertyManager.json';
import RentalDistributorABI from '../abi/RentalDistributor.json';

// Placeholder addresses (to be replaced post-deployment)
export const PROPERTY_TOKEN_ADDRESS: Address = '0x0000000000000000000000000000000000000001';
export const PROPERTY_MANAGER_ADDRESS: Address = '0x0000000000000000000000000000000000000002';
export const RENTAL_DISTRIBUTOR_ADDRESS: Address = '0x0000000000000000000000000000000000000003';
export const USDC_TESTNET_ADDRESS: Address = '0x0000000000000000000000000000000000000004';

export const contracts = {
  propertyToken: {
    address: PROPERTY_TOKEN_ADDRESS,
    abi: PropertyTokenABI,
  },
  propertyManager: {
    address: PROPERTY_MANAGER_ADDRESS,
    abi: PropertyManagerABI,
  },
  rentalDistributor: {
    address: RENTAL_DISTRIBUTOR_ADDRESS,
    abi: RentalDistributorABI,
  },
} as const;
