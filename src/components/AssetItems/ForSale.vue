<template>
	<div class="container">
		<h2 class="title">Asset For Sale</h2>

		<div class="flex asset-item-list">
			<ul v-for="item in assetItems" :key="item">
				<li>
					<img class="asset-item" :src="item.tokenURI" alt="Asset" />
				</li>
				<li class="price">
					Price: {{ item.price }} ETH
					<button
						class="purchase-btn"
						@click="purchase(item.id, item.price)"
					>
						Purchase
					</button>
				</li>
			</ul>
		</div>
	</div>
</template>

<script>
import { ref } from "vue";
import { formatEther, parseEther } from "ethers/lib/utils";

import { UseEthers } from "@/plugins/ethers";

export default {
	async setup() {
		const ethers = UseEthers();
		const assetItemIds = Number(await ethers._assetItemIds());

		const assetItems = ref([]);

		for (let i = 1; i <= assetItemIds; i++) {
			const [id, priceInWei, tokenURI] = await ethers.getAssetItem(i);
			const price = formatEther(priceInWei);

			assetItems.value.push({
				id,
				price,
				tokenURI
			});
		}

		const purchase = async (id, price) => {
			await ethers.purchaseAssetItem(id, {
				value: parseEther(price.toString())
			});
		};

		return {
			assetItems,
			purchase
		};
	}
};
</script>

<style scoped>
.container {
	width: 100%;
}

.price {
	border-bottom-left-radius: 6px;
	border-bottom-right-radius: 6px;
	text-align: center;
	background-color: #060606;
	margin-top: -5px;
	font-weight: bold;
	font-family: "Open Sans", sans-serif;
	font-size: 1em;
	padding: 10px;

}

.purchase-btn {
	margin-left: 10px;
	background-color: rgb(22, 128, 57);
}
</style>
