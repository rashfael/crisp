<template lang="jade">
.supplier-details(v-scrollbar.y="")
	h2 {{ supplier.name }}
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
	created () {
		// api.suppliers.statistics(this.$route.params.id)
		Promise.all([api.suppliers.get(this.$route.params.id)]).then(([supplier, history]) => {
			this.supplier = supplier
		})
	},
	methods: {

	},
	events: {
	}
}
</script>
<style lang="stylus">
@import "~_settings"

.supplier-details
	card()
	width 1200px
	margin 0 auto
	position: relative
	table.history, table.arrivals
		table()
</style>
