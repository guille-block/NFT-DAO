// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/DAOsNFTs.sol";
import "../src/TimeLockNFTs.sol";
import "../src/DAO.sol";

abstract contract TimeLockTest is Test {
    TimeLockNFTs internal timeLockNFTs;

    function setUp() public virtual {
        timeLockNFTs = new TimeLockNFTs();
    }
    
}

abstract contract DaoToken is TimeLockTest {
    DAOsNFTs nft;
    function setUp() public virtual override {
        super.setUp();
        vm.prank(address(1));
        nft = new DAOsNFTs(100);
    }
    
}

contract DaoTests is DaoToken {
    DAO dao;
    function setUp() public override {
        super.setUp();
        dao = new DAO("Test DAO", 4, nft, timeLockNFTs);
        vm.startPrank(address(timeLockNFTs));
        timeLockNFTs.grantRole(timeLockNFTs.TIMELOCK_ADMIN_ROLE(), address(dao));
    }

    function testChangedTheRoleToDao_TL() public {
        assertEq(timeLockNFTs.hasRole(timeLockNFTs.TIMELOCK_ADMIN_ROLE(),address(dao)), true);
    }


}