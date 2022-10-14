pragma solidity >= 0.8;

import "lib/openzeppelin-contracts/contracts/proxy/utils/Initializable.sol";
import "solmate/tokens/ERC1155.sol";

contract NFTERC1155 is ERC1155, Initializable {
    string public name;
    string private contract_uri;
    string private token_uri;
    uint256 private idCount;
    address public owner;

    function initialize(string calldata _name, string calldata _contract_uri, string calldata _token_uri) initializer public {
        name = _name;
        contract_uri = _contract_uri;
        token_uri = _token_uri;

        owner = msg.sender;
    }

    function contractURI() public view returns (string memory) {
        return contract_uri;
    }

    function uri(uint256) public view override  returns (string memory) {
        return token_uri;
    }

    function mint(
        address _to,
        uint256 _id,
        uint256 _amount) payable public {
        require(msg.value >= 0.2 ether);
        _mint(_to, ++idCount, _amount, "");
    }

    function withDrawFunds() public {
        payable(owner).call{value: address(this).balance}("");
    }
}