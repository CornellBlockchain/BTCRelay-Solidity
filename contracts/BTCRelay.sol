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
  function storeBlockHeader(bytes header){
    require(header.length >= 80);
    uint32 version_ = uint32(uint(bytesToBytes4(header, 0)));
    bytes32 prevBlock_ = bytesToBytes32(header, 4);
    bytes32 merkleRoot_ = bytesToBytes32(header, 36);
    uint32 time_ =  uint32(uint(bytesToBytes4(header, 68)));
    uint32 nBits_ = uint32(uint(bytesToBytes4(header, 72)));
    uint32 nonce_ = uint32(uint(bytesToBytes4(header, 76)));

    bytes32 index = dblShaFlip(header);
    blockHeaders[index] = Header(version_, prevBlock_, merkleRoot_, time_, nBits_, nonce_);
  }


  function bytesToBytes32(bytes b, uint offset) private pure returns (bytes32) {
    bytes32 out;

    for (uint i = 0; i < 32; i++) {
      out |= bytes32(b[offset + i] & 0xFF) >> (i * 8);
    }
    return out;
  }

  function bytesToBytes4(bytes b, uint offset) private pure returns (bytes4) {
    bytes4 out;

    for (uint i = 0; i < 4; i++) {
      out |= bytes4(b[offset + i] & 0xFF) >> (i * 8);
    }
    return out;
  }

  // computeMerkle(txHash, txIndex, siblings) computes the Merkle root of the
  // block that the transaction corresponding to txHash was included in.
  function computeMerkle(bytes32 txHash, uint txIndex, bytes32[] siblings) pure returns (bytes32 merkleRoot){

  }

  // Computes the target from the compressed "bits" form
  // https://bitcoin.org/en/developer-reference#target-nbits
  function targetFromBits(uint32 nBits) pure returns (bytes32 target){

  }

  // Converts the input to the opposite endianness
  function flip32(bytes32) pure returns (bytes32) {

  }

  // BTC-style reversed double sha256
  function dblShaFlip(bytes data) pure returns (bytes32){
    bytes32 headerPt1 = 0x020000007ef055e1674d2e6551dba41cd214debbee34aeb544c7ec6700000000;
    return headerPt1; //dummy function, delet this.
  }

}
