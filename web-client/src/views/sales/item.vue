<template lang="jade">
.sale-details
	h2 {{ sale._id }}

	ui-tabs
		ui-tab(header="Details")
			table.details
				tbody
					tr
						th Bonnummer
						td sale._id
					tr
						th Datum
						td {{ sale.date | datetime }}
					tr
						th Kundennummer
						td {{ sale.customerId }}
					tr
						th Kassiererin
						td {{ sale.cashier }}
					tr
						th Betrag
						td {{ sale.price | currency }}
					tr
						th Rabatt
						td {{ sale.discount | percentage }}
		ui-tab(header="Posten")
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
@import '~_ui'

.sale-details
	card()
	width 1200px
	margin 0 auto

	table.details, table.sale-items, table.coupons, table.returns
		table()
</style>
