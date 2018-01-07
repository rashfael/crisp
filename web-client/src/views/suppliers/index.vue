<template lang="jade">
#suppliers.index(v-if="suppliers")
	.toolbar
		.actions
			router-link(:to="{name: 'suppliers:new'}").new Neuer Lieferant
			form.search(@submit.prevent='loadItems')
				label(for='search'): i.fa.fa-search
				input#search(type='text', v-model="search")
	.list
		.thead
			.id #
			.name Name
		.tbody(v-scrollbar.y="")
			.item(v-for="supplier in suppliers", @click="$router.push({name:'suppliers:supplier', params:{id: supplier.id}})")
				.id {{supplier.id}}
				.name {{supplier.name}}
</template>
<script>
import { mapState } from 'vuex'

export default {
	data () {
		return {
			search: '',
		}
	},
	computed: {
		...mapState(['suppliers'])
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
