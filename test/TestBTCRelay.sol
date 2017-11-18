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
  /*
    BTCRelay relay = BTCRelay(DeployedAddresses.BTCRelay());

    bytes32 data_0 = 0xad10a7b01eab11ca1eaba15c11ba05f0;
    bytes32 sha_0 = 0x0;
    bytes32 data_1 = 0x11000000000000000000000000000000;
    bytes32 sha_1 = 0x0;
    bytes32 data_2 = 0x11000000000000000000000000000000110000000000000000000000000000ab;
    bytes32 sha_2 = 0x0;

    Assert.equal(relay.dblShaFlip(data_0), sha_0, "dblShaFlip should return reversed double sha256");
    Assert.equal(relay.dblShaFlip(data_1), sha_1, "dblShaFlip should return reversed double sha256");
    Assert.equal(relay.dblShaFlip(data_2), sha_2, "dblShaFlip should return reversed double sha256");

  }
  */
}
