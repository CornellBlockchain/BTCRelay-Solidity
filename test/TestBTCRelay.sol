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

  function testGetPrevBlock() {
  	BTCRelay relay = BTCRelay(DeployedAddresses.BTCRelay());
    bytes memory header = hex"02000000b6ff0b1b1680a2862a30ca44d346d9e8910d334beb48ca0c00000000000000009d10aa52ee949386ca9385695f04ede270dda20810decd12bc9b048aaab3147124d95a5430c31b18fe9f0864";
    bytes32 res = relay.getPrevBlock(header);
    Assert.equal(res, 0xb6ff0b1b1680a2862a30ca44d346d9e8910d334beb48ca0c0000000000000000, "getTPrevBlock");


  }

}
