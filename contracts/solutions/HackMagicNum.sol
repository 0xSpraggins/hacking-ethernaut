// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

interface IMagicNum {
    function setSolver(address _solver) external;
}

interface ISolver {
    function whatIsTheMeaningOfLife() external view returns (uint256);
}

contract HackMagicNum {
    IMagicNum private _magicNum;
    ISolver private _solver;

    // Deploys the solver contract and sets it as the solver for the MagicNum contract
    /**
     * @dev How the bytecode for the solver contract was generated:
     * @notice runtime code needs to return 42
     * RETURN(offset, size) optcode 32 bytes (0x20) starting at memory 0
     * store 42 (0x2a) to memory using MSTORE(offset, value)
     * @dev Runtime bytecode creation:
     * PUSH1 0x2a => 60 2a
     * PUSH1 0 => 60 00
     * MSTORE => 52
     * 
     * PUSH1 0x20 => 60 20
     * PUSH1 0 => 60 00
     * RETURN => f3
     * ---------------------
     * Runtime bytecode: 0x602a60005260206000f3 (10 bytes)
     * ---------------------
     * 
     * @notice Creation code deploys contract and runtime code
     * store runtime code to memory MSTORE(offset, value)
     * return 10 bytes of data from offset 22
     * @dev Creation bytecode creation:
     * PUSH10 602a60005260206000f3 => 69 602a60005260206000f3
     * PUSH1 => 60 00
     * MSTORE => 52
     * 
     * PUSH1 0x0a => 60 0a
     * PUSH1 0x16 => 60 16
     * RETURN => f3
     * ----------------------------------
     * Creation code bytecode: 0x69602a60005260206000f3600052600a6016f3
     */ 
    constructor(address magicNum) {
        _magicNum = IMagicNum(magicNum);
        address solverAddr;
        bytes memory bytecode = hex"69602a60005260206000f3600052600a6016f3";
        // Deploy the solver contract
        assembly {
            // 0 ETH transfer, 0x20 = offset 32bytes, 0x13 = creation code size = 19bytes
            solverAddr := create(0, add(bytecode, 0x20), 0x13)
        }
        require(solverAddr != address(0), "Deployment failed");

        _magicNum.setSolver(solverAddr);
    }
}