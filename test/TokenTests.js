const { expect } = require("chai");
const { ethers } = require("hardhat");

// using alias to enable shorthand notation.
// we can now write eth('200') instead of ethers.utils.parseEther('200')
const { parseEther: eth } = ethers.utils;

describe("[ Test The World of Tokens ]", function () {
  let owner, attacker;

  before(async function () {
    /* Setup -- DO NOT TOUCH */

    [owner, attacker] = await ethers.getSigners();

    // for readibility in --trace logs.
    hre.tracer.nameTags[owner.address] = "Owner";
    hre.tracer.nameTags[attacker.address] = "Attacker";

    this.badTransferToken = await (await ethers.getContractFactory("BadTransferToken", owner)).deploy("BadTransferToken", "BADTRNSFR");
    await this.badTransferToken.deployed();
    hre.tracer.nameTags[this.badTransferToken.address] = "BadTransferToken";

    this.rektContract = await (await ethers.getContractFactory("RektContract", owner)).deploy(this.badTransferToken.address);
    await this.rektContract.deployed();
    hre.tracer.nameTags[this.rektContract.address] = "RektContract";

    this.badTransferTokenInitFunds = 100;
    await this.badTransferToken.safeTransfer(this.rektContract.address, this.badTransferTokenInitFunds);

    this.rektContract = this.rektContract.connect(attacker);
  });


  it("is rekt by a badTransfer token -- 01-BadTransfer_Token", async function () {

    console.log("\n================= Test 01-BadTransfer_Token Start ==============================\n");

    console.log("\nRektContract balance before attack   : %s", await this.rektContract.getBadTokenBalanceOfContract());
    console.log("Attacker token balance before attack : %s\n", await this.badTransferToken.balanceOf(attacker.address));
    
    await this.rektContract.play({ value: eth('1'), gasLimit: 4500000 });
    
    console.log("\nRektContract balance after attack    : %s", await this.rektContract.getBadTokenBalanceOfContract());
    console.log("Attacker token balance after attack  : %s\n", await this.badTransferToken.balanceOf(attacker.address));
    
    expect(await this.rektContract.getBadTokenBalanceOfContract(), "RektContract not fully drained!").to.eq(0);
    expect(await this.badTransferToken.balanceOf(attacker.address), "Attacker's token balance still zero!").to.eq(this.badTransferTokenInitFunds);

    console.log("\n=================  Test 01-BadTransfer_Token End  ==============================\n");

  });


});
