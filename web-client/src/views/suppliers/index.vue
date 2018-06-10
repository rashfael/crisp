<template lang="jade">
#suppliers.index(v-if="suppliers")
	.toolbar
		.actions
			router-link(:to="{name: 'suppliers:new'}").new Neuer Lieferant
			form.search(@submit.prevent)
				label(for='search'): i.material-icons search
				bunt-input#search(name="search", v-model="search")
	.list
		.thead
			.id #
			.name Name
		.tbody(v-scrollbar.y="")
			.item(v-for="supplier in filteredSuppliers", @click="$router.push({name:'suppliers:supplier', params:{id: supplier.id}})")
				.id {{supplier.id}}
				.name {{supplier.name}}
</template>
<script>
import { mapState } from 'vuex'
import fuzzysearch from 'fuzzysearch'
export default {
	data () {
		return {
			search: '',
		}
	},
	computed: {
		...mapState(['suppliers']),
		filteredSuppliers () {
			const search = this.search.trim().toLowerCase()
			return this.suppliers.filter((supplier) => supplier.id.toString().indexOf(search) >= 0 || fuzzysearch(search, supplier.name.toLowerCase()))
		}
	},
	methods: {
	}
}
</script>
<style lang="stylus">
@import '~_settings'

#suppliers
	.bunt-button.new
		button-style(color: $crisp-primary)

	.list
		.id
			width: 240px
</style>
