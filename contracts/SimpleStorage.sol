// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

contract SimpleStorage{
    uint256 favoriteNumber;

    People public person = People({favoriteNumber: 2, name: "Samuel O"});

    People[] public peoples;

    mapping(string => uint256) public nameToFavoriteNumber;

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }

    function addPeople (string memory _name, uint256 _favoriteNumber) public {
        peoples.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }
}