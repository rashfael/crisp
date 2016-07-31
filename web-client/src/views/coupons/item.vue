<template lang="jade">
.coupon-details.details
	h1 Gutschein {{ coupon._id }}

	table.details
		tbody
			tr
				th Gutscheinnummer
				td {{ coupon._id }}
			tr
				th Aktueller Wert
				td {{ coupon.value | currency }}

	h2 Veränderungen
	table.changes
		thead
			tr
				th Bonnummer
				th Datum
				th Wertänderung
		tbody
			tr(v-for="item in coupon.items")
				td: a(v-link="'/sales/'+item.saleId") {{ item.saleId }}
				td {{ item.date | date }}
				td {{ item.valuechange | currency }}
</template>
<script>
import api from 'lib/api'

export default {
	data() {
		return {
			coupon: {}
		}
	},
	route: {
		data(transition) {
			return api.coupons.get(this.$route.params.id).then((coupon) => {
				return {
					coupon
				}
			})
		}
	}
}
</script>
<style lang="stylus">
@import '~_ui'

.coupon-details
	table.details, table.changes
		table()
</style>
