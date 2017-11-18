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

  event partialFlip(bytes32 data);
  // storeBlockHeader(header) pareses a length 80 bytes and stores the resulting
  // Header struct in the blockHeaders mapping, where the index is the blockhash
  function storeBlockHeader(bytes header){}

  // computeMerkle(txHash, txIndex, siblings) computes the Merkle root of the
  // block that the transaction corresponding to txHash was included in.
  function computeMerkle(bytes32 txHash, uint txIndex, bytes32[] siblings) pure returns (bytes32 merkleRoot){}

  // Computes the target from the compressed "bits" form
  // https://bitcoin.org/en/developer-reference#target-nbits
  function targetFromBits(uint32 nBits) pure returns (bytes32 target){}

  // Converts the input to the opposite endianness
  function flip32(bytes32 le) pure returns (bytes32 be) {
      be = 0x0;
      for (uint256 i = 0; i < 32; i++){
        be >>= 8;
        be |= le[i];
      }
  }

  // BTC-style reversed double sha256
  function dblShaFlip(bytes data) returns (bytes32){
      return flip32(sha256(sha256(data)));
  }

}
