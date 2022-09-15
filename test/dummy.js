const Dummy = artifacts.require("Dummy");

contract('Dummy', (accounts) => {
  it('extract signer', async () => {
    const DummyInstance = await Dummy.deployed();
    const signer = await DummyInstance.checkAccess.call(
      "0xb453bd4e271eed985cbab8231da609c4ce0a9cf1f763b6c1594e76315510e0f1",
      "0x1b",
      "0x611168801b33f1b568c17d0c2874e3c5eb968911bb222e66852f373e87701399",
      "0x394662eb2358b6a59edd29b1176c25b33b005b0721335321ffa66c916df15568"
    );

    assert.equal(signer, "0x1CA2A05AA2B6221B88E918d15171F8258b6bB967");
  });

  it('hash door', async () => {
    const DummyInstance = await Dummy.deployed();
    const hash = await DummyInstance.getHashedMessage.call("1234");

    assert.equal(hash, "0x25674ba4b416425b2ac42fdb33d0b0c20c59824a76e1ee4ecc04b8d48f8f6af7");
  });
});