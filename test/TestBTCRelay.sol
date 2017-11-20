import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/BTCRelay.sol";

contract TestBTCRelay {

  function testFlip32() {
    BTCRelay relay = BTCRelay(DeployedAddresses.BTCRelay());

    bytes32 le_0 = 0xad10a7b01eab11ca1eaba15c11ba05f0;
    bytes32 be_0 = 0xf005ba115ca1ab1eca11ab1eb0a710ad00000000000000000000000000000000;
    bytes32 le_1 = 0x11000000000000000000000000000000;
    bytes32 be_1 = 0x0000000000000000000000000000001100000000000000000000000000000000;
    bytes32 le_2 = 0x11000000000000000000000000000000110000000000000000000000000000ab;
    bytes32 be_2 = 0xab00000000000000000000000000001100000000000000000000000000000011;

    Assert.equal(relay.flip32(le_0), be_0, "flip32 should convert LE <-> BE");
    Assert.equal(relay.flip32(le_1), be_1, "flip32 should convert LE <-> BE");
    Assert.equal(relay.flip32(le_2), be_2, "flip32 should convert LE <-> BE");
  }

  function testDblShaFlip() {

    BTCRelay relay = BTCRelay(DeployedAddresses.BTCRelay());
    bytes32 sha_0 = 0x8c14f0db3df150123e6f3dbbf30f8b955a8249b62ac1d1ff16284aefa3d06d87;
    Assert.equal(relay.dblShaFlip(hex"01000000010000000000000000000000000000000000000000000000000000000000000000ffffffff08044c86041b020602ffffffff0100f2052a010000004341041b0e8c2567c12536aa13357b79a073dc4444acb83c4ec7a0e2f99dd7457516c5817242da796924ca4e99947d087fedf9ce467cb9f7c6287078f801df276fdf84ac00000000"), sha_0, "dblShaFlip should return reversed double sha256");
  }

  function testTargetFromBits() {
    BTCRelay relay = BTCRelay(DeployedAddresses.BTCRelay());

    uint32 bit1 = 0x18062776;
    bytes32 result1 = 0x0000000000000000062776000000000000000000000000000000000000000000;

    uint32 bit2 = 0x16062435;
    bytes32 result2 = 0x0000000000000000000006243500000000000000000000000000000000000000;

    uint32 bit3 = 0x20062423;
    bytes32 result3 = 0x0624230000000000000000000000000000000000000000000000000000000000;

    Assert.equal(relay.targetFromBits(bit1), result1, "targetFromBits does not pass this test");
    Assert.equal(relay.targetFromBits(bit2), result2, "targetFromBits does not pass this test");
    Assert.equal(relay.targetFromBits(bit3), result3, "targetFromBits does not pass this test");
  }

  function testGetPrevBlock() {
  	BTCRelay relay = BTCRelay(DeployedAddresses.BTCRelay());
    bytes memory header = hex"02000000b6ff0b1b1680a2862a30ca44d346d9e8910d334beb48ca0c00000000000000009d10aa52ee949386ca9385695f04ede270dda20810decd12bc9b048aaab3147124d95a5430c31b18fe9f0864";
    bytes32 res = relay.getPrevBlock(header);
    Assert.equal(res, 0xb6ff0b1b1680a2862a30ca44d346d9e8910d334beb48ca0c0000000000000000, "getTPrevBlock");


  }

  function testComputeMerkle() {

    BTCRelay b = new BTCRelay();

    bytes32 txHash = 0x8c14f0db3df150123e6f3dbbf30f8b955a8249b62ac1d1ff16284aefa3d06d87;
    uint txIndex = 0;
    bytes32[] memory sibling = new bytes32[](2);
    sibling[0] = 0xfff2525b8931402dd09222c50775608f75787bd2b87e56995a7bdd30f79702c4;
    sibling[1] = 0x8e30899078ca1813be036a073bbf80b86cdddde1c96e9e9c99e9e3782df4ae49;
    bytes32 expMerkle = 0xf3e94742aca4b5ef85488dc37c06c3282295ffec960994b2c0d5ac2a25a95766;

    bytes32 result = b.computeMerkle(txHash, txIndex, sibling);
    Assert.equal(result, expMerkle, "Result should equal the example merkle");


    bytes32 internalHash = 0xccdafb73d8dcd0173d5d5c3c9a0770d0b3953db889dab99ef05b1907518cb815;
    bytes32[] memory sibling2 = new bytes32[](1);
    sibling2[0] = sibling[1];
    result = b.computeMerkle(internalHash, txIndex, sibling2);
    Assert.equal(result, expMerkle, "Result internal should equal example merkle");

    txHash = 0x80c6f121c3e9fe0a59177e49874d8c703cbadee0700a782e4002e87d862373c6;
    bytes32[] memory sibling3 = new bytes32[](1);
    txIndex = 1;
    sibling3[0] = 0xb86f5ef1da8ddbdb29ec269b535810ee61289eeac7bf2b2523b494551f03897c;
    result = b.computeMerkle(txHash, txIndex, sibling3);
    expMerkle = 0x5140e5972f672bf8e81bc189894c55a410723b095716eaeec845490aed785f0e;
    Assert.equal(result, expMerkle, "Test from BTC block 99997");
  }

}
