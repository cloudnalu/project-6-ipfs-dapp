<template>
	<section class="flex asset-items-container">
		<Suspense>
			<ForSale />
		</Suspense>

		<Suspense>
			<Purchased />
		</Suspense>
	</section>
</template>

<script>
import ForSale from "./ForSale";
import Purchased from "./Purchased";

export default {
	components: {
		ForSale,
		Purchased
	}
};
</script>

<style>
.asset-items-container {
	flex-direction: column;
	width: 100%;
}

.asset-item-list {
	flex-wrap: wrap;
	justify-content: space-around;
}

.asset-item-list ul {
	list-style-type: none;
	margin: 0;
	padding: 0;
}

.asset-item {
	max-width: 450px;
	max-height: 450px;
	object-fit: contain;
	border-top-left-radius: 6px;
	border-top-right-radius: 6px;
}

.title {
	text-align: center;
	font-family: "Fredoka One", sans-serif;
	font-size: 3em;
}
</style>
