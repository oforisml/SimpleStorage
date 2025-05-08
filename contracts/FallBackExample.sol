// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
contract FallBackExample {
    uint256 public results;

    receive() external payable {
        results = 1;
    }

    fallback() external  payable {
        results = 6;
    }
}