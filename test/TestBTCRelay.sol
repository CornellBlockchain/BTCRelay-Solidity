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
  }

}
