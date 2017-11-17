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
    // sample raw blockheader
    bytes firstBlock = 0x02000000b6ff0b1b1680a2862a30ca44d346d9e8910d334beb48ca0c00000000000000009d10aa52ee949386ca9385695f04ede270dda20810decd12bc9b048aaab3147124d95a5430c31b18fe9f0864;
    bytes32 firstBlockHash = 0x5cc926d366330f309d43f0d72d044f88b2319e5731023ff705ba8a1d54068c58;

    bytes secondBlock = 0x020000005cc926d366330f309d43f0d72d044f88b2319e5731023ff705ba8a1d54068c589d10aa52ee949386ca9385695f04ede270dda30810de1d12bc9b048baab3147124d95a5530c31b18fe9f0864;
    bytes32 secondBlockHash = 0x9ff3f845af2d8ffc284037277c4f29a8c2abb69563da63e3da6f6dc375fff223;
    relay.storeBlockHeader(firstBlock);
    relay.storeBlockHeader(secondBlock);
    Assert.equal(relay.getPrevBlock(secondBlockHash), firstBlockHash, "getPrevBlock should = previous block hash");


  }

}
