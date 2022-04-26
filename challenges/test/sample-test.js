const { expect, assert } = require("chai");
const { ethers } = require("hardhat");

describe("Greeter", function () {
  it("Should solve challenge 1", async function () {
    const Ch1 = await ethers.getContractFactory("Challenge1");
    const ch1 = await Ch1.deploy();
    await ch1.deployed();

    const [wallet] = await ethers.getSigners();
    var func_selector = "0x1ab0cb3a"
    var answer = 1234
    var packed_data = ethers.utils.solidityPack(["bytes4", "uint"], [func_selector, answer]);

    var tx = await wallet.sendTransaction({
      to: ch1.address,
      data: packed_data,
    });
    var rec = await tx.wait();

    // Listen for the Winner event
    let abi = ["event Winner(address winnerAddr)"];
    let iface = new ethers.utils.Interface(abi);
    let log;
    if (rec.logs.length != 0) {
      log = iface.parseLog(rec.logs[0]); // here you can add your own logic to find the correct log
    }
    expect(log.args.winnerAddr).to.equal(wallet.address);

  });
  it("Should solve challenge 2", async function () {
    const Ch2 = await ethers.getContractFactory("Challenge2");
    const ch2 = await Ch2.deploy();
    await ch2.deployed();

    const [wallet] = await ethers.getSigners();
    var func_selector = "0xe6581e4c"
    var answer = 10
    var packed_data = ethers.utils.solidityPack(["bytes4", "uint"], [func_selector, answer]);

    var tx = await wallet.sendTransaction({
      value: ethers.utils.parseUnits("1", "wei"),
      to: ch2.address,
      data: packed_data,
    });
    var rec = await tx.wait();

    // Listen for the Winner event
    let abi = ["event Winner(address winnerAddr)"];
    let iface = new ethers.utils.Interface(abi);
    let log;
    if (rec.logs.length != 0) {
      log = iface.parseLog(rec.logs[0]); // here you can add your own logic to find the correct log
    }
    expect(log.args.winnerAddr).to.equal(wallet.address);
  });
});
