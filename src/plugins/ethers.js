import { ethers } from "ethers";
import { inject } from "vue";

import DigitalAsset from "../abis/DigitalAsset.json";

const ETHERS_INJECTION_KEY = "ETHERS";

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
