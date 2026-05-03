// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "src/print/console.sol";
// Testing neovim and wsl to update changes
contract MyContract {
    string public message = "Hello CLM";
    address public admin;

    modifier onlyAdmin(){
        require(msg.sender == admin, "Only admin allowed");
        _;
    }
    constructor(){
        admin = msg.sender;
    }
    function setMessage(string memory _msg) public {
        console.log(_msg);
        message = _msg;
    }
}

