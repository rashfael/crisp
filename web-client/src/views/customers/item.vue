<template lang="jade">
.customer-details.details(v-if="customer")
	h2 {{ customer.name }}

	bunt-tabs(:active-tab="this.$route.name")
		bunt-tab(header="Details", id="customers:customer", @selected="tabSelected")

	router-view.content(:customer="customer")
//- 	ui-tabs
//- 		ui-tab(header="Details")
//- 			edit(:customer="customer")
//- 		ui-tab(header="Historie")
//- 			table.history
//- 				tr
//- 					th Bonnummer
//- 					th Datum
//- 					th Summe
//- 					th Rabatt
//- 				tr(v-for="item in history")
//- 					td: a(v-link="{name: 'sale', params:{id: item._id}}") {{ item._id }}
//- 					td {{ item.date | datetime }}
//- 					td {{ item.price | currency }}
//- 					td {{ item.discount | percentage }}
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
	created () {
		api.customers.get(this.$route.params.id).then((customer) => {
			this.customer = customer
		})
	},
	methods: {
		tabSelected (id) {
			this.$router.replace({name: id, params: this.$route.params})
		},
	},
	events: {
	}
}
</script>
<style lang="stylus">
@import "~_settings"

.customer-details
	table.history, table.arrivals
		table()
</style>
