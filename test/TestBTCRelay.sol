import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/BTCRelay.sol";

contract TestBTCRelay {

  function testFlip32() {
    BTCRelay relay = BTCRelay(DeployedAddresses.BTCRelay());

    bytes32 le = 0xad10a7b01eab11ca1eaba15c11ba05f0;
    bytes32 be = 0xf005ba115ca1ab1eca11ab1eb0a710ad00000000000000000000000000000000;

    Assert.equal(relay.flip32(le), be, "flip32 should convert LE <-> BE");
  }
  function testStoreBlockHeader(){
    BTCRelay relay = BTCRelay(DeployedAddresses.BTCRelay());

    bytes32 headerPt1 = 0x020000007ef055e1674d2e6551dba41cd214debbee34aeb544c7ec6700000000;
    bytes32 headerPt2 = 0x00000000d3998963f80c5bab43fe8c26228e98d030edf4dcbe48a666f5c39e2d;
    bytes16 headerPt3 = 0x7a885c9102c86d536c890019593a470d;
    bytes memory testHeader = new bytes(160);
    for(uint x = 0; x < 32; x ++){
      testHeader[x] = headerPt1[x];
    } //I have no clue how to declare an 80 bytes literal in one go so I did it like this.


    relay.storeBlockHeader(testHeader);
    uint32 version;
    bytes32 prevBlock;
    bytes32 merkleRoot;
    uint32 time;
    uint32 nBits;
    uint32 nonce;
    (version, prevBlock, merkleRoot, time, nBits, nonce) = relay.blockHeaders(0x020000007ef055e1674d2e6551dba41cd214debbee34aeb544c7ec6700000000);
    uint version_ = uint(version);
    uint nonce_ = uint(nonce);
    Assert.equal(prevBlock, merkleRoot, "I cannot figure this part out");
  }

}
