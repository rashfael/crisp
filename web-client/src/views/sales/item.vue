<template lang="jade">
.sale-details
	.details-data
		table
			tbody
				tr
					th Bonnummer
					td {{ sale._id }}
				tr
					th Datum
					td {{ sale.date | datetime }}
				tr
					th Kundennummer
					td: a(v-link="{name: 'customer', params:{id:sale.customerId}}") {{ sale.customerId }}
				tr
					th Kassiererin
					td {{ sale.cashier }}
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
					th Betrag
					th Rabatt
					th Anzahl
			tbody
				tr(v-for="item in sale.items")
					td: a(v-link="'/products/'+item.productId") {{ item.productId }}
					td {{ item.price | currency }}
					td {{ item.discount | percentage }}
					td {{ item.amount }}

		h2 Gutscheine
		table.coupons
			thead
				tr
					th Gutscheinnummer
					th Wertänderung
			tbody
				tr(v-for="item in sale.coupons")
					td: a(v-link="'/coupons/'+item.couponId") {{ item.couponId} }
					td {{ item.valuechange | currency }}

		h2 Rückgaben
		table.returns
			thead
				tr
					th Bonnummer
					th Betrag
			tbody
				tr(v-for="item in sale.returns")
					td: a(v-link="'/sales/'+item.saleId") {{ item.saleId }}
					td {{ item.price | currency }}

</template>
<script>
import api from 'lib/api'

export default {
	data() {
		return {
			sale: {}
		}
	},
	route: {
		data(transition) {
			return api.sales.get(this.$route.params.id).then((sale) => {
				return {
					sale
				}
			})
		}
	}
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
