# NFT-DAO

Basic NFT goverened DAO which aims to create new ERC1155 nft collections from a clone factory based on goverened standard proposals
## Objective
The idea is to create a DAO that through an ERC721 governance, it can create new ERC1155 collections dynamically using a clone factory implementation. The project was built with Foundry for its simplicity at the moment of testing different cases but can be extended to harhat or truffle as well. 
This application aims to be a tool for the gaming industry, as a governing set of users can propose new characters for different games in a progresive way, while mantaining the entire governance of them.
In the upcoming days, the ERC1155 collections will have an extensible preset of on-chain metadata to have a different alternative as well.

## Testing

You can clone the repository and run 

```
forge install
```

followed by 

```
forge test -vvv
```
