<template>
	<section class="flex nav-bar">
		<button class="connect-btn" @click="connect()">
			Connect to App
		</button>
		<template class="flex" v-if="account">
			<button
				class="withdraw-btn"
				v-if="!hasPayment"
				@click="checkPayments()"
			>
				Check for Payments
			</button>
			<button
				class="admin-btn"
				v-if="account"
				@click="toggleCircuitBreaker()"
			>
				Open/Close Store
			</button>

			<button class="withdraw-btn" v-else @click="withdrawPayments()">
				Withdraw Payments
			</button>
		</template>
	</section>
	<section class="flex home-container">
		<h1 class="title">Buy & Sell Digital Assests</h1>
		<AddAssetItem />
		<AssetItems />
	</section>
			<AssetItems />

</template>

<script>
import { ref, provide } from "vue";

import { UseEthers } from "@/plugins/ethers";
import Components from "@/components/index";
import { ACCOUNT_INJECTION_KEY } from "./constants";

export default {
	components: {
		...Components
	},

	setup() {
		const account = ref("");
		const hasPayment = ref(false);
		const ethers = UseEthers();

		const checkPayments = async () => {
			hasPayment.value = Number(await ethers.payments(account.value)) > 0;
		};

		const withdrawPayments = async () => {
			await ethers.getPayments();
			hasPayment.value = false;
		};

		const toggleCircuitBreaker = async () => {
			await ethers.toggleCircuitBreaker();
		};

		const connect = async () => {
			const ethAccounts = await window.ethereum.request({
				method: "eth_requestAccounts"
			});

			account.value = ethAccounts[0];
		};

		provide(ACCOUNT_INJECTION_KEY, account);

		return {
			connect,
			account,
			hasPayment,
			checkPayments,
			withdrawPayments,
			toggleCircuitBreaker
		};
	}
};
</script>

<style scoped>
.home-container {
	flex-direction: column;
	align-items: center;
}

.title {
	font-size: 3em;
	margin: 0;
	padding: 50px 0 20px 0;
	font-family: "Open Sans", sans-serif;
}

.connect-btn {
	margin: 20px;
	background-color: rgb(100, 100, 100);
}

.withdraw-btn {
	background-color: rgb(22, 128, 57);
	margin: 20px;
}
.admin-btn {
	background-color: rgb(22, 128, 57);
	margin: 20px;
}
.nav-bar {
	align-items: left;
}
</style>
