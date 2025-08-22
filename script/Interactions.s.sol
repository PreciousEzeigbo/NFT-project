// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {BasicNft} from "../src/BasicNft.sol";
import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script {
    string public constant BERNARD =
        "https://ipfs.io/ipfs/QmPmzwyJZTjerFbNivFcjQR9mZd1U3YPZQSNKx5nERMifG?filename=st-bernard.json";

    function run() external {
        address basicNftAddress = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );
        mintNftOnContract(basicNftAddress);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(BERNARD);
        vm.stopBroadcast();
    }
}
