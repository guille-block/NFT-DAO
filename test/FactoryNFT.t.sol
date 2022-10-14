pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "../src/FactoryNFT.sol";


contract FactoryNFTTest is Test {
    FactoryNFT factoryNFT;
    function setUp() public {
        factoryNFT = new FactoryNFT();
    }

    function testCreateCollection() public {
        //factoryNFT.createCollectionNFTERC1155("Colllection 1", "https//:contract_url", "https//:token_url");
        bytes memory data = abi.encodeWithSelector(FactoryNFT.createCollectionNFTERC1155.selector, "NFT COLLECTION 1", "https//:contract_url", "https//:token_url");
        console2.logBytes(data);
        address(factoryNFT).call{value:0}(data);
        assertEq(factoryNFT.countCollections(), 1);
    }
}