pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/TimeLockNFTs.sol";

abstract contract TimeLockTest is Test {
    TimeLockNFTs timeLockNFTs;

    function setUp() public {
        timeLockNFTs = new TimeLockNFTs();
    }

    function testChangeTheRole() public {
        vm.startPrank(address(timeLockNFTs));
        timeLockNFTs.grantRole(timeLockNFTs.TIMELOCK_ADMIN_ROLE(),address(2));
        assertEq(timeLockNFTs.hasRole(timeLockNFTs.TIMELOCK_ADMIN_ROLE(),address(2)), true);
    }
    
}