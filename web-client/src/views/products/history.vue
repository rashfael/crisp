<template lang="jade">
.product-history
	.list
		.thead
			.id Bonnummer
			.date Datum
			.customer Kunde
			.price Betrag
			.discount Rabatt
		.tbody(ref="list", v-scrollbar.y="")
			router-link.item(v-for="sale in product.sales", v-if="sale.id", :to="{name:'sales:sale', params:{id: sale.id}}", :key="sale.id")
				.id {{ sale.id }}
				.date {{ sale.date | datetime }}
				.customer {{ sale.customer_name }}
				.price {{ sale.price | currency }}
				.discount {{ sale.discount | percentage }}
</template>
<script>

export default {
	props: {
		product: Object
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
.product-history
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
