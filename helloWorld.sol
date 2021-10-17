

pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;


contract helloWorld{

    uint32 public timestamp;
    uint32 public number;

    // Contract can have a `constructor` – function that will be called when contract will be deployed to the blockchain.
    // In this example constructor adds current time to the instance variable.
    // All contracts need call tvm.accept(); for succeeded deploy
    constructor() public {
        // Check that contract's public key is set
        require(tvm.pubkey() != 0, 101);
        // Check that message has signature (msg.pubkey() is not zero) and
        // message is signed with the owner's private key
        require(msg.pubkey() == tvm.pubkey(), 102);
        // The current smart contract agrees to buy some gas to finish the
        // current transaction. This actions required to process external
        // messages, which bring no value (henceno gas) with themselves.
        tvm.accept();

        number = 1;
        timestamp = now;
    }

    function multiply (uint32 multiplyTo) public checkOwnerAndAccept checkMultiplyRule(multiplyTo) {
        tvm.accept();
        number *= multiplyTo;
    }

    modifier checkMultiplyRule(uint32 number) {
        require(number >= 1 && number <=10, 100);
        _;
    }

    modifier checkOwnerAndAccept() {
        require(msg.pubkey() == tvm.pubkey(), 102);
        tvm.accept();
        _;
    }
}
