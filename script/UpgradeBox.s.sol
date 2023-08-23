// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {Box1} from "../src/Box1.sol";
import {Box2} from "../src/Box2.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract UpgradeBox is Script {
    function run() public returns (address) {
        address proxy = DevOpsTools.get_most_recent_deployment(
            "ERC1967Proxy",
            block.chainid
        );
        vm.startBroadcast();
        address box2 = _deployBox2();
        upgradeBox(proxy, box2);
        vm.stopBroadcast();
        return proxy;
    }

    function upgradeBox(address proxy, address newBox) public {
        Box1(proxy).upgradeTo(newBox);
    }

    function _deployBox2() private returns (address) {
        Box2 box2 = new Box2();
        return address(box2);
    }
}
