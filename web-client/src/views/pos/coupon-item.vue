<template lang="jade">
.item.coupon-item
	.article-id
	.article-name Gutschein
	cell-decimal-input.item-price(name="item-price", v-model="value.price")
	.item-discount –
	.item-amount –
	input.item-sum(name="item-sum", :value="sum", :readonly="true")
</template>
<script>
import Decimal from 'decimal.js'
import CellDecimalInput from './cell-decimal-input'

const priceFormat = new Intl.NumberFormat('de-DE', {minimumFractionDigits: 2, maximumFractionDigits: 2})

export default {
	components: { CellDecimalInput },
	props: {
		value: {
			type: Object,
			required: true
		}
	},
	data () {
		return {
		}
	},
	computed: {
		sum: {
			get () {
				return priceFormat.format(this.value.price)
			}
		},
		amount: {
			get () {
				return this.value.amount
			},
			set (v) {
				if (Number.isInteger(v)) {
					this.value.amount = v
				}
			}
		}
	},
	created () {},
	mounted () {
		this.$nextTick(() => {
		})
	},
	methods: {}
}
</script>
<style lang="stylus">
#pos .coupon-item
	.article-id, .article-name, .item-discount, .item-amount
		line-height: 48px
	.item-discount, .item-amount
		text-align: right
</style>
