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

}
