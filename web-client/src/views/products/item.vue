<template lang="jade">
.product-details.details(v-if="product")
	h2 {{ product.name }}

	bunt-tabs(:active-tab="this.$route.name")
		bunt-tab(header="Details", id="products:product", @selected="tabSelected")
		bunt-tab(header="Lager", id="products:arrivals", @selected="tabSelected")
		bunt-tab(header="Historie", id="products:history", @selected="tabSelected")
			//- button() Drucken
	router-view(:product="product")
		//- ui-tab(header="Historie")
		//- 	table.history
		//- 		tr
		//- 			td Kunde
		//- 			td Bonnummer
		//- 			td Datum
		//- 		tr(v-for="item in history")
		//- 			td: a(v-link="{name: 'customer', params:{id:item.customerId}}") {{ item.customerId }}
		//- 			td: a(v-link="{name: 'sale', params:{id:item.saleId}}") {{ item.saleId }}
		//- 			td {{ item.date | datetime }}
		//- ui-tab#arrivals(header="Lagerbestand")
		//- 	form(@submit.prevent="addArrival")
		//- 		bunt-input(name="name", :value.sync="arrivalAmount", label="Anzahl")
		//- 		button(type='submit') Hinzufügen
		//- 	table
		//- 		tr
		//- 			td Datum
		//- 			td Anzahl
		//- 		tr(v-for="arrival in product.arrivals")
		//- 			td {{ arrival.date }}
		//- 			td {{ arrival.amount }}

</template>
<script>
import api from 'lib/api'
import Decimal from 'decimal.js'
export default {
	data() {
		return {
			arrivalAmount: 0,
			product: null,
			history: []
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
		},
		addArrival() {
			api.products.addArrival(this.product._id, this.arrivalAmount).then((product) => {
				this.product.arrivals = product.arrivals
			})
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
</style>
