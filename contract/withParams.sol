// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract CounterLab {
    uint256 public count;

    constructor(uint256 initialCount) {
        count = initialCount;
    }

    function increment() public {
        count += 1;
    }

    function setCount(uint256 nextCount) public {
        count = nextCount;
    }

    function readCount() public view returns (uint256) {
        return count;
    }
}

