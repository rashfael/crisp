<template lang="jade">
.supplier-details.details(v-scrollbar.y="")
	h2 {{ supplier.name }}
	bunt-tabs(:active-tab="this.$route.name")
		bunt-tab(header="Details", id="suppliers:supplier", @selected="tabSelected")
		bunt-tab(header="Historie", id="suppliers:history", @selected="tabSelected")
	router-view.content(:supplier="supplier")
</template>
<script>
import api from 'lib/api'
import Edit from './edit'

export default {
	components: {Edit},
	data () {
		return {
			supplier: {},
			history: []
		}
	},
	created () {
		api.suppliers.get(this.$route.params.id).then((supplier) => {
			this.supplier = supplier
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

.supplier-details
	card()
	width 1200px
	margin 0 auto
	position: relative
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
</style>
