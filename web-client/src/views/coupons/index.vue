<template lang="jade">
#coupons.index(v-if="coupons")
	.toolbar
		.actions
			form.search
				label(for='search'): i.material-icons search
				bunt-input#search(name="search", :value="search", @input="onSearch")
	.list
		.thead
			.id #
			.value Restwert
		.tbody(ref="list", v-scrollbar.y="")
			router-link.item(v-for="coupon in coupons", v-if="coupon.id", :to="{name:'coupons:coupon', params:{id: coupon.id}}", :key="coupon.id")
				.id {{ coupon.id }}
				.value {{ coupon.changes.reduce((acc, val) => acc += val.value_change, 0) | currency }}
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
			coupons: null,
			loading: true,
			next: null,
			search: ''
		}
	},
	created () {
		api.coupons.list().then((response) => {
			this.coupons = response.results
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
				this.coupons.push(...response.results)
				this.next = response.next
				this.loading = false
			})
		},
		onSearch (value) {
			this.search = value
			this.loading = true
			this.$refs.list.scrollTop = 0
			api.coupons.list(this.search).then((response) => {
				this.coupons = response.results
				this.next = response.next
				this.loading = false
			})
		}
	}
}
</script>
<style lang="stylus">
@import '~_settings'

#coupons

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
