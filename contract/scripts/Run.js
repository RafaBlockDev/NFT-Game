const main = async () => {
    const gameContractFactory = await hre.ethers.getContractFactory("NFTGame");
    const gameContract = await gameContractFactory.deploy(
        ["Rafa", "Joshua", "Val"], // Names
        ["https://i.imgur.com/pKd5Sdk.png", // Images
        "https://i.imgur.com/xVu4vFL.png", 
        "https://i.imgur.com/WMB6g9u.png"],
        [100, 200, 300], // HP Values
        [100, 50, 25],   // Attack damage values
        "Elon Musk", // Big Boss
        "https://i.imgur.com/AksR0tt.png",
        10000,
        50
    );
    await gameContract.deployed();
    console.log("📝 Contract deployed to: ", gameContract.address);

    let txn;
    txn = await gameContract.mintCharacterNFT(2);
    await txn.wait();
    
    txn = await gameContract.attackBoss();
    await txn.wait();

    txn = await gameContract.attackBoss();
    await txn.wait();

    console.log("Done!");
        
}

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();
