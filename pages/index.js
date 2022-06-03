import styles from '../styles/Home.module.css'
import twitterLogo from "../images/twitter-logo.svg";

export default function Home() {
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
          <img alt="Twitter Logo" className={styles.twitter_logo} src={twitterLogo} />
          <a
            className={styles.footer_text}
            href=""
            target="_blank"
            rel="noreferrer"
          >{`built with @rafaelfuentes.eth`}</a>
        </div>
      </div>
    </div>
  );
}
