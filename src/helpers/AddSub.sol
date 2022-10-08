pragma solidity >=0.8;

contract AddSub {
    event ChangeNumber(uint256 number);
    uint8 public num;

    function add() public {
        emit ChangeNumber(num++);
    }

    function sub() public {
        emit ChangeNumber(num--);
    }
}
