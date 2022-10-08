pragma solidity >=0.8;

contract AddSub {
    uint8 public num;

    function add() public {
        ++num;
    }

    function sub() public {
        --num;
    }
}
