import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as dotenv from 'dotenv';

dotenv.config();

let { GOERLI_PRIVATE_KEY, GOERLI_ALCHEMY_API_KEY } = process.env;

if (GOERLI_PRIVATE_KEY == undefined) {
  GOERLI_PRIVATE_KEY = '';
}

const config: HardhatUserConfig = {
  solidity: "0.8.17",
  networks: {
    hardhat: {
      chainId: 1337
    },
    goerli: {
      chainId: 5,
      url: `https://goerli.infura.io/v3/4132b7a34e7c42c3953062934b7d44f7`,
      accounts: [GOERLI_PRIVATE_KEY]
    }
  }
};

export default config;