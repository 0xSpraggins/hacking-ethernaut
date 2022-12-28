import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from 'dotenv';

dotenv.config();

const GOERLI_ALCHEMY_API_KEY: string | undefined = process.env.GOERLI_ALCHEMY_API_KEY;
const GOERLI_PRIVATE_KEY: string = process.env.GOERLI_PRIVATE_KEY ? process.env.GOERLI_PRIVATE_KEY : '';

const config: HardhatUserConfig = {
  solidity: "0.8.17",
  networks: {
    hardhat: {
      chainId: 1337
    },
    goerli: {
      url: `https://eth-goerli.g.alchemy.com/v2/${GOERLI_ALCHEMY_API_KEY}`,
      accounts: [GOERLI_PRIVATE_KEY]
    }
  }
};

export default config;