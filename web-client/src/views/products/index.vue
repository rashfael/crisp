<template lang="jade">
#products.list(v-if="items")
	.toolbar
		.actions
			a.new(v-link="{name: 'new-product'}") Neuer Artikel
			form.search(@submit.prevent='loadItems')
				label(for='search'): i.material-icons search
				input#search(type='text', v-model="search")
		pagination(:pages="pages", :current-page="currentPage", :total="items.metadata.totalCount", :items-per-page="100", @change-page="changePage")
	table
		tr
			th Artikelnummer
			th Name
			th Gruppe
			th Lieferant
			th LiefNr
			th EK
			th VK
			th Lager
		tr(v-for="item in items.items", :item="item", @click="$router.go({name:'product', params:{id: item._id}})")
			td {{item._id}}
			td {{item.name}}
			td {{humanize.productGroupsMap[item.productGroupId].name}}
			td {{humanize.suppliersMap[item.supplierId].name}}
			td {{item.supplierProductId}}
			td {{item.cost | currency}}
			td {{item.sale | currency}}
			td {{item.stock}}
</template>
<script>
import api from 'lib/api'
import ListMixin from 'components/mixins/list'
import humanize from 'lib/humanize'
export default {
	mixins: [ListMixin],
	data() {
		return {
			baseUrl: 'products',
			humanize
		}
	},
	methods: {

	},
	events: {
	}
}
</script>
<style lang="stylus">
</style>
