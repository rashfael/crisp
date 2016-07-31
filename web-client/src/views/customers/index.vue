<template lang="jade">
#customers.list(v-if="items")
	.toolbar
		.actions
			a.new(v-link="{name: 'new-customer'}") Neuer Kunde
			form.search(@submit.prevent='loadItems')
				label(for='search'): i.material-icons search
				input#search(type='text', v-model="search")
		pagination(:pages="pages", :current-page="currentPage", :total="items.metadata.totalCount", :items-per-page="100", @change-page="changePage")
	table
		tr
			th Kundennummer
			th Name
			th Vorname
		tr(v-for="item in items.items", :item="item", @click="$router.go({name:'customer', params:{id: item._id}})")
			td {{item._id}}
			td {{item.name}}
			td {{item.forename}}
</template>
<script>
import api from 'lib/api'
import ListMixin from 'components/mixins/list'

export default {
	mixins: [ListMixin],
	data() {
		return {
			baseUrl: 'customers'
		}
	}
}
</script>
<style lang="stylus">
</style>
