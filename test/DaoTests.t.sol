// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/DAOsNFTs.sol";
import "../src/TimeLockNFTs.sol";
import "../src/DAO.sol";
import "../src/helpers/AddSub.sol";
import "forge-std/console2.sol";

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
    AddSub addSub;
    function setUp() public override {
        super.setUp();
        addSub = new AddSub();
        dao = new DAO("Test DAO", 4, nft, timeLockNFTs);
        vm.startPrank(address(timeLockNFTs));
        timeLockNFTs.grantRole(timeLockNFTs.TIMELOCK_ADMIN_ROLE(), address(dao));
        timeLockNFTs.grantRole(timeLockNFTs.PROPOSER_ROLE(), address(dao));
        timeLockNFTs.grantRole(timeLockNFTs.EXECUTOR_ROLE(), address(dao));
        vm.stopPrank();
    }

    function testChangedTheRoleToDao_TL() public {
        vm.startPrank(address(timeLockNFTs));
        assertEq(timeLockNFTs.hasRole(timeLockNFTs.TIMELOCK_ADMIN_ROLE(),address(dao)), true);
        vm.stopPrank();
    }


    function testVoteProposal() public {
        uint256 id = _createProposalForAddSub();
        uint256 proposalState1 = uint256(dao.proposalSnapshot(id));
        uint8 state1 = uint8(dao.state(id));
        console2.log(state1);
        vm.roll(block.number+2);
        assertEq(uint256(dao.proposalSnapshot(id)), 2);
        _voteOnProposal(id);
        uint256 proposalState2 = uint256(dao.proposalSnapshot(id));
        uint8 state2 = uint8(dao.state(id));
        console2.log(state2);
        vm.roll(dao.proposalDeadline(id)+1);
        (uint256 votesAgainst, uint256 votesFor, uint256 votesAbstain) = dao.proposalVotes(id);
        console2.log(votesFor);
        assertEq(uint256(dao.state(id)), 4);
    }

    function _createProposalForAddSub() private returns (uint256) {
        vm.startPrank(address(1));
        address[] memory targetAdd = new address[](1);
        uint256[] memory targetVal = new uint256[](1);
        bytes[] memory targetData = new bytes[](1);
        string memory targetDesc = "Add 1 to number";

        targetAdd[0] = address(addSub);
        targetVal[0] = 0;
        targetData[0] = abi.encodeWithSignature("add()");

        nft.delegate(address(1));

        uint256 proposalHashId = dao.propose(targetAdd, targetVal, targetData, targetDesc);
        vm.stopPrank();
        return proposalHashId;
        
    }

    function _voteOnProposal(uint256 _proposalHashId) private {
        vm.startPrank(address(1));
        dao.castVote(_proposalHashId, 1);
        vm.stopPrank();
    }
}