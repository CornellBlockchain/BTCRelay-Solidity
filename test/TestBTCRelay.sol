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

  function testGetTimestamp () {
    BTCRelay relay = BTCRelay(DeployedAddresses.BTCRelay());
    //bytes memory header = [byte(0), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0xab, 0xcd, 0xef, 0x12, 0,0,0,0,0,0,0,0];
    bytes memory header = hex"0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000abcdef120000000000000000";
    uint res = relay.getTimestamp(header);
    Assert.equal(res, 0xabcdef12, "getTimestamp");
  }
}
