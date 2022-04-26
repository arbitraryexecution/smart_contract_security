require("dotenv").config();
require("@nomiclabs/hardhat-waffle");

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  networks: {
    hardhat: {
      forking: {
        url: process.env.ALCHEMYURL,
        blockNumber: 9504626,
      },
    },
  },
  solidity: {
    compilers: [
      {
        version: "0.4.18",
      },
      {
        version: "0.4.25",
      },
      {
        version: "0.5.8",
      },
      {
        version: "0.8.9",
      },
    ],
  },
};
