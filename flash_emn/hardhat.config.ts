import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config();

let { ALCHEMY_URI } = process.env;

const config: HardhatUserConfig = {
    solidity: "0.6.6",
    networks: {
        hardhat: {
            forking: {
                url: ALCHEMY_URI,
                blockNumber: 10954001
            }
        }
    }
};

export default config;
