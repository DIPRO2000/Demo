// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract array {
    
    uint[] public arr;

    function enterData(uint num) public {
        arr.push(num);    
    }

    function getData(uint index) public view returns(uint) {
        return arr[index];
    }

    function getAllData() public view returns( uint[] memory )
    {
        return arr;
    }
}