<template lang="jade">
.customer-details.details
	h2 {{ customer.name }}

	ui-tabs
		ui-tab(header="Details")
			edit(:customer="customer")
		ui-tab(header="Historie")
			table.history
				tr
					th Bonnummer
					th Datum
					th Summe
					th Rabatt
				tr(v-for="item in history")
					td: a(v-link="{name: 'sale', params:{id: item._id}}") {{ item._id }}
					td {{ item.date | datetime }}
					td {{ item.price | currency }}
					td {{ item.discount | percentage }}
</template>
<script>
import api from 'lib/api'
import Edit from './edit'

export default {
	components: {Edit},
	data() {
		return {
			customer: {},
			history: []
		}
	},
	route: {
		data(transition) {
			return Promise.all([api.customers.get(this.$route.params.id), api.customers.history(this.$route.params.id)]).then(([customer, history]) => {
				return {
					customer,
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

.customer-details
	table.history, table.arrivals
		table()
</style>
