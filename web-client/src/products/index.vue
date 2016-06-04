<template lang="jade">
#products
	#subnav
		#actions
			a(href='/products/new') Neuer Artikel
			form.search
				label(for='search'): i.fa.fa-search
				input#search(type='text')
		#pagination
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
		tr(is="list-item", v-for="item in items", :item="item")
</template>
<script>
import api from '../api'
import ListItem from './list-item'

export default {
	components: {'list-item': ListItem},
	data() {
		return {
			items: []
		}
	},
	methods: {

	},
	created() {
		api.products.list().then((json) => this.items = json.items)
	},
	ready() {

	},
	events: {
	}
}
</script>
<style lang="stylus">
</style>
