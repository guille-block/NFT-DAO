pragma solidity >=0.8;

import "lib/openzeppelin-contracts/contracts/proxy/Clones.sol";
import "./helpers/NFTERC1155.sol";
import "forge-std/console2.sol";

contract FactoryNFT {
    address owner;
    address immutable tokenImplementation;
    address[] public clones;
    uint256 public countCollections;

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
    constructor() {
        tokenImplementation = address(new NFTERC1155());
        owner = msg.sender;
    }

    function createCollectionNFTERC1155(string calldata _name, string calldata _contract_uri, string calldata _token_uri) external onlyOwner returns (address) {
        console2.logBytes(msg.data);
        address clone = Clones.clone(tokenImplementation);
        console2.log(clone);
        NFTERC1155(clone).initialize(_name, _contract_uri, _token_uri);
        clones.push(clone);
        ++countCollections;
        return clone;
    }

}