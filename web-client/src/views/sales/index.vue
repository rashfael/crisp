<template lang="jade">
#sales.list(v-if="items")
	.toolbar
		.actions
			form.search(@submit.prevent='loadItems')
				label(for='search'): i.material-icons search
				input#search(type='text', v-model="search")
		pagination(:pages="pages", :current-page="currentPage", :total="items.metadata.totalCount", :items-per-page="100", @change-page="changePage")
	table
		tr
			th Bonnummer
			th Datum
			th Kunde
			th Betrag
			th Rabatt
		tr(v-for="item in items.items", :item="item", @click="$router.go({name:'sale', params:{id: item._id}})")
			td {{ item._id }}
			td {{ item.date | date}}
			td {{ item.customerId }}
			td {{ item.price | currency }}
			td {{ item.discount | percentage }}
</template>
<script>
import api from 'lib/api'
import ListMixin from 'components/mixins/list'

export default {
	mixins: [ListMixin],
	data() {
		return {
			baseUrl: 'sales'
		}
	}
}
</script>
<style lang="stylus">
</style>
