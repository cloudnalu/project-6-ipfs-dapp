import { createApp } from "vue";
import App from "./App.vue";
import { IPFS_INJECTION_KEY, newIPFS } from "./plugins/ipfsHttpClient";
import { ETHERS_INJECTION_KEY, newEthers } from "./plugins/ethers";

const app = createApp(App);

// Inject the IPFS and web3 connection for use anywhere in the app.
app.provide(IPFS_INJECTION_KEY, newIPFS());
app.provide(ETHERS_INJECTION_KEY, newEthers());

app.mount("#app");
