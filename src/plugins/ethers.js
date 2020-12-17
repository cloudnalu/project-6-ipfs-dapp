import { ethers } from "ethers";
import { inject } from "vue";

// Import the ABI
import DigitalAsset from "../../build/contracts/DigitalAsset.json";

const ETHERS_INJECTION_KEY = "ETHERS";

// Instantiate web3 conection, connect to the smasset contract.
const newEthers = () => {
	const provider = new ethers.providers.Web3Provider(window.ethereum);
	const signer = provider.getSigner();

	return new ethers.Contract(
		DigitalAsset.networks[5777].address,
		DigitalAsset.abi,
		signer
	);
};

function UseEthers() {
	const ethers = inject(ETHERS_INJECTION_KEY);

	if (!ethers) {
		throw new Error("Ethers contract instance not found");
	}

	return ethers;
}

export { ETHERS_INJECTION_KEY, newEthers, UseEthers };
