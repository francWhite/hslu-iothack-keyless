pragma solidity 0.8.17;

contract Dummy {
    function checkAccess(bytes32 _hashedMessage, uint8 _v, bytes32 _r, bytes32 _s) public pure returns (address signer) {
        return ecrecover(_hashedMessage, _v, _r, _s);
    }

    function getHashedMessage(string memory _door) public pure returns (bytes32 hash) {
        bytes memory prefix = "\x19Ethereum Signed Message:\n";
        // bytes32 hashedMessage = keccak256(abi.encodePacked(_door));
        return keccak256(abi.encodePacked(prefix, bytes(_door).length, _door)); 
    }
}
