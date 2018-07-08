<template lang="jade">
.sale-details(v-if="sale")
	.details-data
		table
			tbody
				tr
					th Bonnummer
					td {{ sale.id }}
				tr
					th Datum
					td {{ sale.date | datetime }}
				tr
					th Kundennummer
					td: router-link(:to="{name: 'customers:customer', params:{id: sale.customer }}") {{ sale.customer_name }}
				tr
					th Kassiererin
					td {{ usersMap[sale.user].username }}
				tr
					th Betrag
					td {{ sale.price | currency }}
				tr
					th Rabatt
					td {{ sale.discount | percentage }}
	.sale-data
		h2 Produkte
		table.sale-items
			thead
				tr
					th ProduktId
					th Name
					th Rabatt
					th Anzahl
					th Betrag
			tbody
				tr(v-for="item in sale.sale_items")
					td: router-link(:to="{name: 'products:product', params: {id: item.product}}") {{ item.product }}
					td {{ item.product_name }}
					td {{ item.discount | percentage }}
					td {{ item.price | currency }}


		h2 Gutscheine
		table.coupons
			thead
				tr
					th Gutscheinnummer
					th Wertänderung
			tbody
				tr(v-for="item in sale.coupon_items")
					td: router-link(:to="{name: 'coupons:coupon', params: {id: item.coupon}}") {{ item.coupon }}
					td {{ item.value_change | currency }}

		h2 Rückgaben
		table.returns
			thead
				tr
					th Bonnummer
					th ProduktId
					th Name
					th Anzahl
					th Betrag
			tbody
				tr(v-for="item in sale.return_items")
					td: router-link(:to="{name: 'sales:sale', params: {id: item.sale}}") {{ item.sale }}
					td: router-link(:to="{name: 'products:product', params: {id: item.product}}") {{ item.product }}
					td {{ item.product_name }}
					td {{ item.amount }}
					td {{ item.price | currency }}

</template>
<script>
import api from 'lib/api'
import { mapState } from 'vuex'

export default {
	data () {
		return {
			sale: null
		}
	},
	computed: {
		...mapState(['usersMap'])
	},
	created () {
		api.sales.get(this.$route.params.id).then((sale) => {
			this.sale = sale
		})
	},
}
</script>
<style lang="stylus">
@import "~_settings"

.sale-details
	width 1200px
	margin 0 auto
	display flex
	align-items strech

	.details-data table, table.sale-items, table.coupons, table.returns
		table()

	.details-data
		width 300px
		card()
		margin 0 8px 0 0

		table
			margin 0

			th, td
				height 36px

	.sale-data
		card()
		flex 1

		h2
			margin-left 16px
</style>
