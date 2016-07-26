<template lang="jade">
.supplier-details
	h2 {{ supplier.name }}

	ui-tabs
		ui-tab(header="Details")
			edit(:supplier="supplier")
		//- ui-tab(header="Historie")
		//- 	table.history
		//- 		tr(v-for="item in history")
		//- 			td {{ item.customerId }}
		//- 			td {{ item.saleId }}
		//- 			td {{ item.date }}
		//- ui-tab(header="Lagerbestand")
		//- 	table.arrivals
		//- 		tr
		//- 			td Datum
		//- 			td Anzahl
		//- 		tr(v-for="arrival in product.arrivals")
		//- 			td {{ arrival.item }}
		//- 			td {{ item.amount }}
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
			supplier: {},
			history: []
		}
	},
	route: {
		data(transition) {
			return Promise.all([api.suppliers.get(this.$route.params.id), api.suppliers.statistics(this.$route.params.id)]).then(([supplier, history]) => {
				return {
					supplier,
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

.supplier-details
	card()
	width 1200px
	margin 0 auto

	table.history, table.arrivals
		table()
</style>
