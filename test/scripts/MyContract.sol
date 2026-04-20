// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "clm-cli/console.sol";

contract MyContract {
  string public message = "Hello CLM";

  function setMessage(string memory newMessage) public {
    console.log(newMessage);
    message = newMessage;
  }
}
