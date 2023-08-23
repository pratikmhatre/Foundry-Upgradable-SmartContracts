// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {UUPSUpgradeable} from "@openzeppelin-upgradeable/contracts/proxy/utils/UUPSUpgradeable.sol";

contract Box2 is UUPSUpgradeable {
    uint256 internal someOtherValue;

    function getValue() public view returns (uint256) {
        return someOtherValue;
    }

    function setValue(uint256 _value) public {
        someOtherValue = _value;
    }

    function getVersion() public pure returns (uint256) {
        return 2;
    }

    function _authorizeUpgrade(address newImplementation) internal override {}
}
