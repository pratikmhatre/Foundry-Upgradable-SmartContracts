// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {Box1} from "../src/Box1.sol";
import {Box2} from "../src/Box2.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract DeployBox is Script {
    function run() public returns (address) {
        address proxy = _deployBox();
        return proxy;
    }

    function _deployBox() private returns (address) {
        vm.startBroadcast();
        Box1 box = new Box1();
        ERC1967Proxy proxy = new ERC1967Proxy(address(box), "");
        vm.stopBroadcast();
        return address(proxy);
    }
}
