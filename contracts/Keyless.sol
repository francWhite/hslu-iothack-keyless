pragma solidity 0.8.17;

contract Keyless {
    struct Access {
        address user;
        uint256 door;
        uint256 expirationDate;
    }

    address public owner;
    Access[] private accessList;
    
    constructor() {
        owner = msg.sender;
    }
    
    function addAccess(address _user, uint256 _door, uint256 _expDate) public {
        // TODO only add access if it not exists
        require(msg.sender == owner);
        accessList.push(Access(_user, _door, _expDate));
    }

    function removeAccess(address _user, uint256 _door) public {
        require(msg.sender == owner);
        uint index = 0;
        for(uint i = 0; i < accessList.length; i++) {
            if(accessList[i].user == _user && accessList[i].door == _door) {
                index = i;
                break;
            }
        }
        delete accessList[index];
    }

    function getAccessList() public view returns (Access[] memory) {
        return accessList;
    }

    function checkAccess(bytes32 _hashedMessage, uint8 _v, bytes32 _r, bytes32 _s) public view returns (bool) {
        bytes memory prefix = "\x19Ethereum Signed Message:\n32";
        bytes32 prefixedHashMessage = keccak256(abi.encodePacked(prefix, _hashedMessage));
        address signer = ecrecover(prefixedHashMessage, _v, _r, _s);

        for(uint i = 0; i < accessList.length; i++) {
            //bytes32 doorId = keccak256(abi.encodePacked(accessList[i].door));
            if(accessList[i].user == signer /*&& doorId == _hashedMessage*/) {
                return true;
            }
        }
        return false;
    }

}