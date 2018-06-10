<template lang="jade">
#products.index(v-if="products")
	.toolbar
		.actions
			router-link(:to="{name: 'products:new'}").new Neuer Artikel
			form.search(@submit.prevent="navigateSearch = true")
				label(for='search'): i.material-icons search
				bunt-input#search(name="search", :value="search", @input="onSearch")
	.list
		.thead
			.id Artikelnummer
			.name Name
			.product-group Gruppe
			.supplier Lieferant
			.supplier-product-id LiefNr
			.cost EK
			.price VK
			//- .stock Lager
		.tbody(ref="list", v-scrollbar.y="")
			router-link.item(v-for="product in products", v-if="product.id", :to="{name:'products:product', params:{id: product.id}}", :key="product.id")
				.id {{product.id}}
				.name {{product.name}}
				.product-group {{productGroupsMap[product.product_group].name}}
				.supplier {{suppliersMap[product.supplier].name}}
				.supplier-product-id {{product.supplier_product_id}}
				.cost {{product.cost | currency}}
				.price {{product.sale | currency}}
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
	data () {
		return {
			globals,
			products: null,
			loading: true,
			next: null,
			search: '',
			navigateSearch: true
		}
	},
	created () {
		api.products.list().then((response) => {
			this.products = response.results
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
				this.products.push(...response.results)
				this.next = response.next
				this.loading = false
			})
		},
		onSearch (value) {
			this.search = value
			this.loading = true
			this.navigateSearch = false
			this.$refs.list.scrollTop = 0
			api.products.list(this.search).then((response) => {
				this.products = response.results
				this.next = response.next
				this.loading = false
				if (this.navigateSearch && this.products.length === 1) {
					this.$router.push({name: 'products:product', params: {id: this.products[0].id}})
				}
			})
		}
	}
}
</script>
<style lang="stylus">
@import '~_settings'

#products
	.bunt-button.new
		button-style(color: $crisp-primary)

	.list
		.id
			width: 120px
		.name
			flex: 2
		.product-group, .supplier, .supplier-product-id
			flex: 1 0
		.product-group, .supplier
			text-overflow: ellipsis
			overflow: hidden
		.cost, .price
			width: 52px
			text-align: right
		.stock
			width: 32px
</style>
