//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Owner {

    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "ur not owner");
        _;
    }

}