<template lang="jade">
#suppliers.list(v-if="suppliers")
	.toolbar
		.actions
			bunt-button.new(@click.native="$router.push({name: 'new-supplier'})") Neuer Lieferant
			form.search(@submit.prevent='loadItems')
				label(for='search'): i.fa.fa-search
				input#search(type='text', v-model="search")
	table
		tr
			th #
			th Name
		tr(v-for="supplier in suppliers", @click="$router.push({name:'supplier', params:{id: supplier._id}})")
			td {{supplier.id}}
			td {{supplier.name}}
</template>
<script>
import { mapState } from 'vuex'

export default {
	data () {
		return {
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
</style>
