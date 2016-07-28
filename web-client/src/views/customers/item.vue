<template lang="jade">
.customer-details
	h2 {{ customer.name }}

	ui-tabs
		ui-tab(header="Details")
			edit(:customer="customer")
		ui-tab(header="Historie")
			table.history
				tr(v-for="item in history")
					td {{ item._id }}
					td {{ item.date }}
					td {{ item.price | currency }}
					td {{ item.discount }}

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
	card()
	width 1200px
	margin 0 auto

	table.history, table.arrivals
		table()
</style>
