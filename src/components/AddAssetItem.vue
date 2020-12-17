<template>
	<section class="add-asset-item-container">
		<input type="text-area" v-model="Data" placeholder="Description" />
		<input type="number" v-model="price" placeholder="Price" />
		<label v-if="!assetItem" class="add-asset-item-label">
			<input type="file" accept="image/*" @change="onAssetSelection" />
			Upload Asset
		</label>

		<button v-else @click="addAssetItem()">
			Publish
		</button>
	</section>
</template>

<script>
import { ref } from "vue";
import { parseEther } from "ethers/lib/utils";

import { UseIPFSClient } from "@/plugins/ipfsHttpClient";
import { UseEthers } from "@/plugins/ethers";

export default {
	setup() {
		const ethers = UseEthers();
		const ipfs = UseIPFSClient();

		const price = ref(null);
		const assetItem = ref(null);

		const onAssetSelection = () => {
			assetItem.value = event.target.files[0];
		};

		const addAssetItem = async () => {
			const { path } = await ipfs.add(assetItem.value);
			if (!path) throw new Error("Failed to add asset item to IPFS");

			const tokenURI = `https://ipfs.io/ipfs/${path}`;
			const parsedPrice = parseEther(price.value.toString());
			await ethers.addAssetItem(parsedPrice, tokenURI); 

			// clear input
			price.value = null;
			assetItem.value = null;
		};

		return {
			price,
			assetItem,
			onAssetSelection,
			addAssetItem
		};
	}
};
</script>

<style scoped>
.add-asset-item-container {
	padding: 40px;
}

.add-asset-item-container input {
	padding: 10px;
}

.add-asset-item-label {
	background-color: #ee4540;
	padding: 8px 12px;
	cursor: pointer;
	font-size: 1em;
	font-weight: bold;
	vertical-align: middle;
}

input[type="file"] {
	display: none;
}
</style>
