<template lang="jade">
.product-details.details
	h2 {{ product.name }}

	ui-tabs
		ui-tab(header="Details")
			edit(:product="product")
			//- button() Drucken
		ui-tab(header="Historie")
			table.history
				tr
					td Kunde
					td Bonnummer
					td Datum
				tr(v-for="item in history")
					td: a(v-link="{name: 'customer', params:{id:item.customerId}}") {{ item.customerId }}
					td: a(v-link="{name: 'sale', params:{id:item.saleId}}") {{ item.saleId }}
					td {{ item.date | datetime }}
		ui-tab#arrivals(header="Lagerbestand")
			form(@submit.prevent="addArrival")
				uei-textbox(name="name", :value.sync="arrivalAmount", label="Anzahl")
				button(type='submit') Hinzufügen
			table
				tr
					td Datum
					td Anzahl
				tr(v-for="arrival in product.arrivals")
					td {{ arrival.date }}
					td {{ arrival.amount }}

</template>
<script>
import api from 'lib/api'
import Edit from './edit'

export default {
	components: {Edit},
	data() {
		return {
			arrivalAmount: 0,
			product: {},
			history: []
		}
	},
	route: {
		data(transition) {
			return Promise.all([api.products.get(this.$route.params.id), api.products.history(this.$route.params.id)]).then(([product, history]) => {
				return {
					product,
					history
				}
			})
		}
	},
	methods: {
		addArrival() {
			api.products.addArrival(this.product._id, this.arrivalAmount).then((product) => {
				this.product.arrivals = product.arrivals
			})
		}
	},
	events: {
	}
}
</script>
<style lang="stylus">
@import '~_ui'
.product-details
	table.history, #arrivals table
		table()
</style>
