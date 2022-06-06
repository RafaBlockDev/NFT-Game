import React, { useEffect, useState } from "react";
import styles from '../styles/Home.module.css'

export default function Home() {

  const [currentAccount, setCurrentAccount] = useState(null);

  // Check if there are a ethereum object in the window
  const checkIfWalletIsConnected = async () => {
    try {
      const { ethereum } = window;

      if(!ethereum) {
        alert("Make sure you have Metamask 🦊")
        return;
      } else {
        console.log("We got the Ethereum object!!!! 🥳", ethereum);

        const accounts = await ethereum.request({ method: "eth_accounts"});

        if(accounts.length !== 0) {
          const account = accounts[0];
          console.log("Found an anthourized account: ", account);
          setCurrentAccount(account);
        } else {
          console.log("No anthourized account found");
        }
      }
    }
    catch (error) {
      console.log(error);
    }
  };

  const connectWalletAction = async () => {
    try {
      const { ethereum } = window;

    if (!ethereum) {
    alert ("Get Metamask 🦊")
    return;
    }

    const accounts = await ethereum.request({
      method: "eth_requestAccounts",
    });

    console.log("Connected", accounts[0]);
    setCurrentAccount(accounts[0]);
  } catch (error) {
    console.log(error);
  }
}

  useEffect(() => {
    checkIfWalletIsConnected();
  },[]);

  return (
    <div className={styles.App}>
      <div className={styles.container}>
        <div className={styles.header_container}>
          <p className={styles.header}>Cypherpunk battles</p>
          <p className={styles.sub_text}>Get in into the hackers and cryptographers battles</p>
          <div className={styles.connect_wallet_container}>
            <img
            className={styles.image}
              src="https://media2.giphy.com/media/13INltuXmMfBRe/giphy.gif?cid=ecf05e47q4bukz0r4ggm9qzvhc3h5qa376bn87zueusjsglw&rid=giphy.gif&ct=g"
              alt="Hacker gif"
            />
            <button className={styles.cta_button} onClick={connectWalletAction}>
              Connect Wallet</button>
          </div>
        </div>
        <div className={styles.footer_container}>
          <a
            className={styles.footer_text}
            href=""
            target="_blank"
            rel="noreferrer"
          >{`🦄 Built by @rafaelfuentes.eth`}</a>
        </div>
      </div>
    </div>
  );
}
