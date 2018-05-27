<template lang="jade">
.supplier-history
	.total
		h4 Total:
		h5 {{ supplier.total_sales }}
	.list
		.thead
			.month Monat
			.sum Summe
		.tbody(ref="list", v-scrollbar.y="")
			.item(v-for="stat in supplier.monthly_sales")
				.month {{ stat.month | month }}
				.sum {{ stat.price__sum | currency }}
</template>
<script>

export default {
	props: {
		supplier: Object
	},
	data () {
		return {
		}
	},
	computed: {},
	created () {},
	mounted () {
		this.$nextTick(() => {
		})
	},
	methods: {}
}
</script>
<style lang="stylus">
.supplier-history
	.list
		.month
			flex: 1
		.sum
			width: 240px
</style>
