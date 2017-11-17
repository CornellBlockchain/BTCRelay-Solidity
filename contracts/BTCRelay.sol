pragma solidity ^0.4.18;

contract BTCRelay {

  struct Header {
    uint32 version;
    bytes32 prevBlock;
    bytes32 merkleRoot;
    uint32 time;
    uint32 nBits;
    uint32 nonce;
  }

  mapping(bytes32 => Header) public blockHeaders; // Maps block hashes to headers

  // storeBlockHeader(header) pareses a length 80 bytes and stores the resulting
  // Header struct in the blockHeaders mapping, where the index is the blockhash
  function storeBlockHeader(bytes header){}

  // computeMerkle(txHash, txIndex, siblings) computes the Merkle root of the
  // block that the transaction corresponding to txHash was included in.
  function computeMerkle(bytes32 txHash, uint txIndex, bytes32[] siblings) pure returns (bytes32 merkleRoot){
    merkleRoot = txHash;
    uint256 proofLen = siblings.length;

    uint256 i = 0;
    while (i < proofLen){
      bytes32 proofHex = siblings[i];

      uint256 sideOfSibling = txIndex % 2;

      if (sideOfSibling == 1) {
        merkleRoot = sha256(proofHex, merkleRoot);
      }
      else{
        merkleRoot = sha256(merkleRoot, proofHex);
      }

      txIndex = txIndex / 2;
      i = i + 1;
    }

    return merkleRoot;
  }

  // Computes the target from the compressed "bits" form
  // https://bitcoin.org/en/developer-reference#target-nbits
  function targetFromBits(uint32 nBits) pure returns (bytes32 target){}

  // Converts the input to the opposite endianness
  function flip32(bytes32) pure returns (bytes32) {}

  // BTC-style reversed double sha256
  function dblShaFlip(bytes data) pure returns (bytes32){}

}
