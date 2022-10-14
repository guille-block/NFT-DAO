pragma solidity >= 0.8;

import "lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721Votes.sol";

contract DAOsNFTs is ERC721Votes {

    constructor(uint8 supply) ERC721("DAOsNFTs", "DNFT") EIP712("DAOsNFTs", "1") {
        for(uint8 i = 1; i<=supply;) {
            _mint(msg.sender, i);
            ++i;
        }
        
    }
}

