<template lang="jade">
#products.list(v-if="items")
	.toolbar
		#actions
			a(href='/products/new') Neuer Artikel
			form.search(@submit.prevent='loadItems')
				label(for='search'): i.fa.fa-search
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
		tr(is="list-item", v-for="item in items.items", :item="item", @click="$router.go({name:'product', params:{id: item._id}})")
	//- list(:columns="columns")
</template>
<script>
import api from 'lib/api'
import ListItem from './list-item'
import ListMixin from 'components/mixins/list'

export default {
	components: {ListItem},
	mixins: [ListMixin],
	data() {
		return {
			baseUrl: 'products'
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
