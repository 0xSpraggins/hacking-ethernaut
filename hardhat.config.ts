import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from 'dotenv';

dotenv.config();

let { ACCOUNT_PRIVATE_KEY, SEPOLIA_API_KEY } = process.env;

if (ACCOUNT_PRIVATE_KEY == undefined) {
  ACCOUNT_PRIVATE_KEY = '';
}

const config: HardhatUserConfig = {
  solidity: "0.8.17",
  networks: {
    hardhat: {
      chainId: 1337
    },
    sepolia: {
      chainId: 11155111,
      url: `https://sepolia.infura.io/v3/${SEPOLIA_API_KEY}`,
      accounts: [ACCOUNT_PRIVATE_KEY],
      gasPrice: 3000000000
    }
  }
};

export default config;