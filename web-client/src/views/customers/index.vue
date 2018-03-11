<template lang="jade">
#customers.index(v-if="customers")
	.toolbar
		.actions
			router-link(:to="{name: 'customers:new'}").new Neuer Kunde
			form.search
				label(for='search'): i.material-icons search
				bunt-input#search(name="search", :value="search", @input="onSearch")
	.list
		.thead
			.id Kundennummer
			.name Name
		.tbody(ref="list", v-scrollbar.y="")
			router-link.item(v-for="item in customers", :to="{name:'customers:customer', params:{id: item.id}}", :key="item.id")
				.id {{item.id}}
				.name {{item.forename}} {{item.name}}
			infinite-scroll(ref="infinite", @infinite="onInfinite", :loading="loading")
</template>
<script>
import InfiniteScroll from 'components/infinite-scroll'
import api from 'lib/api'

export default {
	components: {InfiniteScroll},
	data() {
		return {
			customers: null,
			loading: true,
			next: null,
			search: ''
		}
	},
	created () {
		api.customers.list().then((response) => {
			this.customers = response.results
			this.next = response.next
			this.loading = false
		})
	},
	methods: {
		onInfinite () {
			if (!this.next) return
			this.loading = true
			api.fetch(this.next).then((response) => {
				this.customers.push(...response.results)
				this.next = response.next
				this.loading = false
			})
		},
		onSearch (value) {
			this.search = value
			this.loading = true
			this.$refs.list.scrollTop = 0
			api.customers.list(this.search).then((response) => {
				this.customers = response.results
				this.next = response.next
				this.loading = false
			})
		}
	}
}
</script>
<style lang="stylus">
@import '~_settings'

#customers
	.bunt-button.new
		button-style(color: $crisp-primary)

	.list
		.id
			width: 240px
</style>
