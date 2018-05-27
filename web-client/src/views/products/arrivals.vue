<template lang="jade">
.product-arrivals
	.add-arrival
		bunt-input(name="arrival", type="number", v-model="arrivalAmount")
		bunt-button(@click="addArrival") Hinzufügen
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
import api from 'lib/api'

export default {
	props: {
		product: Object
	},
	data () {
		return {
			arrivalAmount: 0
		}
	},
	computed: {},
	created () {},
	mounted () {
		this.$nextTick(() => {
		})
	},
	methods: {
		addArrival () {
			api.products.addArrival(this.product.id, this.arrivalAmount).then((arrival) => {
				this.product.arrivals.unshift(arrival)
			})
		}
	}
}
</script>
<style lang="stylus">
@import '~_settings'

.product-arrivals
	.list
		.date
			width: 240px
	.add-arrival
		display: flex
		padding: 16px
		.bunt-input
			width: 64px
			margin: 0 16px
		.bunt-button
			button-style(color: $clr-primary)
</style>
