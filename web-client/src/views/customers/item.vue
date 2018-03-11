<template lang="jade">
.customer-details.details(v-if="customer")
	h2 {{ customer.forename }} {{ customer.name }}

	bunt-tabs(:active-tab="this.$route.name")
		bunt-tab(header="Details", id="customers:customer", @selected="tabSelected")
		bunt-tab(header="Historie", id="customers:history", @selected="tabSelected")
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
