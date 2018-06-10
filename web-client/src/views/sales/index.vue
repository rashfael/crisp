<template lang="jade">
#sales.index(v-if="sales")
	.toolbar
		.actions
			form.search(@submit.prevent)
				label(for='search'): i.material-icons search
				bunt-input#search(name="search", :value="search", @input="onSearch")
	.list
		.thead
			.id Bonnummer
			.date Datum
			.customer Kunde
			.price Betrag
			.discount Rabatt
		.tbody(ref="list", v-scrollbar.y="")
			router-link.item(v-for="sale in sales", v-if="sale.id", :to="{name:'sales:sale', params:{id: sale.id}}", :key="sale.id")
				.id {{ sale.id }}
				.date {{ sale.date | datetime }}
				.customer {{ sale.customer_name }}
				.price {{ sale.price | currency }}
				.discount {{ sale.discount | percentage }}
				//- .stock {{product.stock}}
			infinite-scroll(ref="infinite", @infinite="onInfinite", :loading="loading")
</template>
<script>
import { mapState } from 'vuex'
import api from 'lib/api'
import InfiniteScroll from 'components/infinite-scroll'
import globals from 'lib/globals'

export default {
	components: {InfiniteScroll},
	data() {
		return {
			globals,
			sales: null,
			loading: true,
			next: null,
			search: ''
		}
	},
	created () {
		api.sales.list().then((response) => {
			this.sales = response.results
			this.next = response.next
			this.loading = false
		})
	},
	computed: {
		...mapState(['suppliersMap', 'productGroupsMap'])
	},
	methods: {
		onInfinite () {
			if (!this.next) return
			this.loading = true
			api.fetch(this.next).then((response) => {
				this.sales.push(...response.results)
				this.next = response.next
				this.loading = false
			})
		},
		onSearch (value) {
			this.search = value
			this.loading = true
			this.$refs.list.scrollTop = 0
			api.sales.list(this.search).then((response) => {
				this.sales = response.results
				this.next = response.next
				this.loading = false
			})
		}
	}
}
</script>
<style lang="stylus">
@import '~_settings'

#sales

	.list
		.id
			width: 120px
		.date
			width: 240px
		.customer
			flex: 2
		.price, .discount
			width: 80px
			text-align: right
</style>
