<template lang="jade">
.product-arrivals
	.list
		.thead
			.date Datum
			.amount Eingang
		.tbody(ref="list", v-scrollbar.y="")
			.item(v-for="arrival in product.arrivals", :key="arrival.date")
				.date {{ arrival.date | datetime }}
				.amount {{ arrival.amount }}
</template>
<script>

export default {
	props: {
		product: Object
	},
	data () {
		return {
		}
	},
	computed: {},
	created () {},
	mounted () {
		this.$nextTick(() => {
		})
	},
	methods: {}
}
</script>
<style lang="stylus">
.product-arrivals
	.list
		.date
			width: 240px
</style>
