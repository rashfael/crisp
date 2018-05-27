<template lang="jade">
.product-details.details(v-if="product")
	h2 {{ product.name }}

	bunt-tabs(:active-tab="this.$route.name")
		bunt-tab(header="Details", id="products:product", @selected="tabSelected")
		bunt-tab(header="Lager", id="products:arrivals", @selected="tabSelected")
		bunt-tab(header="Historie", id="products:history", @selected="tabSelected")
	router-view(:product="product")

</template>
<script>
import api from 'lib/api'
import Decimal from 'decimal.js'
export default {
	data () {
		return {
			product: null
		}
	},
	created () {
		api.products.get(this.$route.params.id).then((product) => {
			product.cost = new Decimal(product.cost)
			product.sale = new Decimal(product.sale)
			this.product = product
		})
	},
	methods: {
		tabSelected (id) {
			this.$router.replace({name: id, params: this.$route.params})
		}
	}
}
</script>
<style lang="stylus">
@import "~_settings"

.product-details
	table.history, #arrivals table
		table()

	.bunt-tabs
		width: auto
		tabs-style(
			background-color: transparent,
			color: $clr-secondary-text-light,
			active-color: $clr-primary-text-light,
			indicator-color: $crisp-primary
		)

	.content
		padding: 16px 64px

	.print
		button-style(color: $clr-primary)
</style>
