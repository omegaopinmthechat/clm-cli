// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "src/print/console.sol";
contract MyContract {
    string public message = "Hello CLM";


    function setMessage(string memory _msg) public {
        console.log(_msg);
        message = _msg;
    }
}

