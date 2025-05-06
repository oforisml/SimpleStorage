// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public simpleStorageArray;
    
    function createSimpleStorageCointract() public {
        SimpleStorage  simpleStorage = new SimpleStorage();
        simpleStorageArray.push(simpleStorage);
    }

    function StoreStorageFactor(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        // simpleStorage.store(_simpleStorageNumber);

        simpleStorageArray[_simpleStorageIndex].store(_simpleStorageNumber);
    }

    function GetStorageFactor(uint256 _simpleStorageIndex) public view returns(uint256){
        SimpleStorage simpleStorage = simpleStorageArray[_simpleStorageIndex];
        return simpleStorage.retrieve();
    }
}