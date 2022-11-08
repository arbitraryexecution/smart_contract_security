// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const { ethers } = require("hardhat");
const hre = require("hardhat");
const { WebhookClient } = require('discord.js');
const wled = require('../../wled_integration');

async function main() {
  // Addr of NFT contract
  const addr = process.env.CTFTOKEN_ADDR

  console.log(`Listening for winners at: ${addr}`);
  const abi = ["event ChallengeSolved(address indexed winner, uint256 indexed levelNum)"];
  const [wallet] = await ethers.getSigners();

  var challenge = new ethers.Contract(addr, abi, wallet);

  // https://github.com/ethers-io/ethers.js/issues/615#issuecomment-848991047
  // Change the polling interval from 4000ms to 1000ms for the event listener
  challenge.provider.pollingInterval = 1000;
  // Save off the old state
  var currentState = await wled.get();
  const webhookClient = new WebhookClient({ url: process.env.DISCORD_URL });

  let filter = challenge.filters.ChallengeSolved(null, null);
  // Listen for the ChallengeSolved event
  challenge.on(filter, async (winner, levelNum) => {

    console.log(`********** ${winner} beat CTF level ${levelNum}! **********`);

    var msg = `${winner} beat CTF level ${levelNum}!`;
    // CTF level 1
    if (levelNum == 1) {
      // make the text red
      msg = "```diff\r\n" + `- ${msg}\r\n` + "```";
      await wled.changeToRed();

    // CTF level 2
    } else if (levelNum == 2) {
      // make the text green
      msg = "```diff\r\n" + `+ ${msg}\r\n` + "```";
      await wled.changeToGreen();

    // CTF level 3
    } else if (levelNum == 3) {
      // make the text blue
      msg = "```ini\r\n" + `[${msg}]\r\n` + "```";
      await wled.changeToBlue();

    // CTF level 4
    } else if (levelNum == 4) {
      // make the text yellow
      msg = "```fix\r\n" + `${msg}\r\n` + "```";
      await wled.changeToYellow();
    }

    webhookClient.send({
      content: msg,
      username: 'CTF Bot',
    });

    // Keep it red for 15 seconds
    await wled.delay(15000);
    // Restore the original colors
    await wled.restoreState(currentState);

  });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main();
