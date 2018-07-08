<template lang="jade">
.coupon-details.details(v-if="coupon")
	h1 Gutschein {{ coupon.id }}

	table.details
		tbody
			tr
				th Gutscheinnummer
				td {{ coupon.id }}
			tr
				th Aktueller Wert
				td {{ remainingValue | currency }}

	h2 Veränderungen
	table.changes
		thead
			tr
				th Bonnummer
				th Datum
				th Wertänderung
		tbody
			tr(v-for="change in coupon.changes")
				td: router-link(:to="{name: 'sales:sale', params: {id: change.sale.id}}") {{ change.sale.id }}
				td {{ change.sale.date | date }}
				td {{ change.value_change | currency }}
</template>
<script>
import api from 'lib/api'

export default {
	data () {
		return {
			coupon: null
		}
	},
	computed: {
		remainingValue () {
			return this.coupon.changes.reduce((acc, val) => acc += val.value_change, 0)
		}
	},
	created () {
		api.coupons.get(this.$route.params.id).then((coupon) => {
			this.coupon = coupon
		})
	},

}
</script>
<style lang="stylus">
@import "~_settings"

.coupon-details
	table.details, table.changes
		table()
</style>
