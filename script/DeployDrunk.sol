// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import {LibDeploy} from "./Deploy.s.sol";

contract DeployScript is Script {
    function run() external {
        vm.startBroadcast();
        address addr = LibDeploy.deployFakeDrunk();
        console.log("deployed drunk token at %s", addr);
        vm.stopBroadcast();
    }
}