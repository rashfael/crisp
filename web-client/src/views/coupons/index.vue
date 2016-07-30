<template lang="jade">
#coupons.list(v-if="items")
	.toolbar
		.actions
			form.search(@submit.prevent='loadItems')
				label(for='search'): i.material-icons search
				input#search(type='text', v-model="search")
		pagination(:pages="pages", :current-page="currentPage", :total="items.metadata.totalCount", :items-per-page="100", @change-page="changePage")
	table
		tr
			th Gutscheinnummer
			th Aktueller Wert
		tr(v-for="item in items.items", :item="item", @click="$router.go({name:'coupon', params:{id: item._id}})")
			td {{ item._id }}
			td {{ item.value | currency }}
</template>
<script>
import api from 'lib/api'
import ListMixin from 'components/mixins/list'

export default {
	mixins: [ListMixin],
	data() {
		return {
			baseUrl: 'coupons'
		}
	}
}
</script>
<style lang="stylus">
</style>
