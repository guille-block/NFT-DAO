// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/DAOsNFTs.sol";

contract Token is Test {
    DAOsNFTs nft;
    function setUp() public {
        vm.prank(address(1));
        nft = new DAOsNFTs(100);
    }

    function testBalanceFromOwner() public {
        assertEq(nft.balanceOf(address(1)), 100);
    }

    function testOwnerOfLastNft() public {
        assertEq(nft.ownerOf(100), address(1));
    }

    function testFail101NftNonExistant() public {
        assertEq(nft.ownerOf(101), address(1));
    }

    function testDelegate() public {
        vm.startPrank(address(1));
        nft.delegate(address(2));
        assertEq(nft.delegates(address(1)), address(2));   
    }

    function testCurrentVotes() public {
        vm.startPrank(address(1));
        nft.delegate(address(2));
        assertEq(nft.getVotes(address(2)), 100);
    }

    function testTransferDelegate() public {
        vm.prank(address(3));
        nft.delegate(address(3));
        vm.startPrank(address(1));
        nft.delegate(address(2));
        nft.safeTransferFrom(address(1), address(3), 100);
        assertEq(nft.getVotes(address(3)), 1);
    }

    function testCurrentVotesAfterTransfer() public {
        vm.prank(address(3));
        nft.delegate(address(3));
        vm.startPrank(address(1));
        nft.delegate(address(2));
        nft.safeTransferFrom(address(1), address(3), 100);
        assertEq(nft.getVotes(address(3)), 1);
        assertEq(nft.getVotes(address(2)), 99);
        assertEq(nft.getVotes(address(1)), 0);
    }

    
}
