<template lang="jade">
.customer-history
	.list
		.thead
			.id Bonnummer
			.date Datum
			.price Betrag
			.discount Rabatt
		.tbody(ref="list", v-scrollbar.y="")
			router-link.item(v-for="sale in customer.sales", v-if="sale.id", :to="{name:'sales:sale', params:{id: sale.id}}", :key="sale.id")
				.id {{ sale.id }}
				.date {{ sale.date | datetime }}
				.price {{ sale.price | currency }}
				.discount {{ sale.discount | percentage }}
</template>
<script>

export default {
	props: {
		customer: Object
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
.customer-history
	.list
		.id
			width: 120px
		.date
			width: 240px
		.price, .discount
			width: 80px
			text-align: right
</style>
