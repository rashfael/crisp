<template lang="jade">
#suppliers.list(v-if="items")
	.toolbar
		.actions
			a.new(v-link="{name: 'new-supplier'}") Neuer Lieferant
			form.search(@submit.prevent='loadItems')
				label(for='search'): i.fa.fa-search
				input#search(type='text', v-model="search")
		pagination(:pages="pages", :current-page="currentPage", :total="items.metadata.totalCount", :items-per-page="100", @change-page="changePage")
	table
		tr
			th #
			th Name
		tr(v-for="item in items.items", :item="item", @click="$router.go({name:'supplier', params:{id: item._id}})")
			td {{item._id}}
			td {{item.name}}
</template>
<script>
import api from 'lib/api'
import ListMixin from 'components/mixins/list'

export default {
	mixins: [ListMixin],
	data() {
		return {
			baseUrl: 'suppliers'
		}
	}
}
</script>
<style lang="stylus">
</style>
