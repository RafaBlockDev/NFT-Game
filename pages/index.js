import React, { useEffect } from "react";
import styles from '../styles/Home.module.css'

export default function Home() {

  const checkIfWalletIsConnected = () => {
    const { ethereum } = window;

    if(!ethereum) {
      alert("Make sure you have Metamask 🦊")
      return;
    } else {
      alert("We got it!!!! 🥳", ethereum);
    }
  };

  useEffect(() => {
    checkIfWalletIsConnected();
  },[]);

  return (
    <div className={styles.App}>
      <div className={styles.container}>
        <div className={styles.header_container}>
          <p className={styles.header}>⚔️ Metaverse Slayer ⚔️</p>
          <p className={styles.sub_text}>Team up to protect the Metaverse!</p>
          <div className={styles.connect_wallet_container}>
            <img
              src="https://64.media.tumblr.com/tumblr_mbia5vdmRd1r1mkubo1_500.gifv"
              alt="Monty Python Gif"
            />
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
