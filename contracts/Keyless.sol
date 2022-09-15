pragma solidity 0.8.17;

contract Keyless {
    struct Access {
        address user;
        string door;
    }

    address public owner;
    Access[] private accessList;
    
    constructor() {
        owner = msg.sender;
    }
    
    function addAccess(address _user, string memory _door) public {
        require(msg.sender == owner);
        
        bool exists = false;
        for (uint i = 0; i < accessList.length; i++) {
            if (accessList[i].user == _user && stringEquals(accessList[i].door, _door)) {
                exists = true;
                break;
            }
        }
        require(exists == false);
        
        accessList.push(Access(_user, _door));
    }

    function removeAccess(address _user, string memory _door) public {
        require(msg.sender == owner);

        uint index = 0;
        for(uint i = 0; i < accessList.length; i++) {
            if(accessList[i].user == _user && stringEquals(accessList[i].door, _door)) {
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
        address signer = ecrecover(_hashedMessage, _v, _r, _s);

        for(uint i = 0; i < accessList.length; i++) {
            if(accessList[i].user == signer &&  hashDoor(accessList[i].door) == _hashedMessage) {
                return true;
            }
        }
        return false;
    }

    function hashDoor(string memory _door) private pure returns (bytes32){
        bytes memory prefix = "\x19Ethereum Signed Message:\n5";
        return keccak256(abi.encodePacked(prefix, _door));
    }

    function stringEquals(string memory a, string memory b) private pure returns (bool){
        return keccak256(abi.encodePacked(a)) == keccak256(abi.encodePacked(b));
    }
}