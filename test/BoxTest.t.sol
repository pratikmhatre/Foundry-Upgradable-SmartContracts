// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {Box1} from "../src/Box1.sol";
import {Box2} from "../src/Box2.sol";
import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";

contract BoxTest is Test {
    DeployBox deployer;
    UpgradeBox upgrader;
    address proxy;

    function setUp() external {
        deployer = new DeployBox();
        upgrader = new UpgradeBox();
        proxy = deployer.run();
    }

    function testBox1VersionMatches() external view {
        assert(Box1(proxy).getVersion() == 1);
    }

    function testSetValueMatchesForBox1() external {
        Box1 box1 = Box1(proxy);
        uint256 expectedValue = 13424;
        box1.setValue(expectedValue);
        assert(box1.getValue() == expectedValue);
    }

    function testSetValueMatchesAfterUpgrade() external {
        Box2 box2 = new Box2();
        upgrader.upgradeBox(proxy, address(box2));
        assert(Box2(proxy).getVersion() == 2);

        uint256 expectedValue = 2533;
        Box1(proxy).setValue(expectedValue);
        assert(Box2(proxy).getValue() == expectedValue);
    }
}
