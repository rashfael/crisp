<template lang="jade">
.product-details
	h2 {{ product.name }}

	ui-tabs
		ui-tab(header="Details")
			edit(:product="product")
		ui-tab(header="Historie")
			table.history
				tr(v-for="item in history")
					td {{ item.customerId }}
					td {{ item.saleId }}
					td {{ item.date }}
		ui-tab(header="Lagerbestand")
			table.arrivals
				tr
					td Datum
					td Anzahl
				tr(v-for="arrival in product.arrivals")
					td {{ arrival.item }}
					td {{ item.amount }}
		//- include ./item-form
		//- button() Drucken
	//- #history
	//- 	table
	//- 		for item in product.history
	//- 			tr
	//- 				td= item.customerId
	//- 				td= item.saleId
	//- 				td= item.date
	//- #arrivals
	//- 	form
	//- 		label Anzahl
	//- 		input(type='text', name='arrival')
	//- 		button(type='submit') Hinzufügen
	//-
	//- 	table
	//- 		thead
	//- 			tr
	//- 				th Datum
	//- 				th Anzal
	//- 		tbody
	//- 			for item in arrivals
	//- 				tr
	//- 					td= formatters.formatDate(item.date)
	//- 					td= item.amount

</template>
<script>
import api from 'lib/api'
import Edit from './edit'

export default {
	components: {Edit},
	data() {
		return {
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

	},
	events: {
	}
}
</script>
<style lang="stylus">
@import '~_ui'

.product-details
	card()
	width 1200px
	margin 0 auto

	table.history, table.arrivals
		table()
</style>
