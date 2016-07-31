<template lang="jade">
.supplier-details
	h2 {{ supplier.name }}

	ui-tabs
		ui-tab(header="Details")
			edit(:supplier="supplier")

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
