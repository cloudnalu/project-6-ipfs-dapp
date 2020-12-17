<template>
	<section class="flex home-container">
		<h1 class="title">Asset Escrow</h1>

		<template class="flex" v-if="account">
			<button v-if="!hasPayment" @click="checkPayments()">
				Check for Payments
			</button>

			<button class="withdraw-btn" v-else @click="withdrawPayments()">
				Withdraw Payments
			</button>
			<button class="admin-btn" @click="toggleCircuitBreaker()">
				Disable/Enable Contract
			</button>

			<AddAssetItem />
			<AssetItems />
		</template>

		<button v-else class="connect-btn" @click="connect()">
			Connect to App
		</button>
	</section>
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

		const connect = async () => {
			const ethAccounts = await window.ethereum.request({
				method: "eth_requestAccounts"
			});

			account.value = ethAccounts[0];
		};
		const toggleCircuitBreaker = async () => {
			await ethers.toggleCircuitBreaker();
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
	margin: 30px 0;
}

.withdraw-btn {
	background-color: rgb(22, 128, 57);
}
.admin-btn {
	background-color: rgb(22, 128, 57);
	margin: 20px;
}
</style>
