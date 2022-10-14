pragma solidity >=0.8;

import "lib/openzeppelin-contracts/contracts/governance/TimelockController.sol";

contract TimeLockNFTs is TimelockController {
    address[] private initialArray; 
    constructor() TimelockController(10, initialArray, initialArray, address(0)) {}
}