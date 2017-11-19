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
