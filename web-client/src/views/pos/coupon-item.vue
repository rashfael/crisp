<template lang="jade">
.item.coupon-item
	.article-id
	.article-name Gutschein
	bunt-input.item-price(name="item-price", v-model="price")
	.item-discount –
	.item-amount –
	bunt-input.item-sum(name="item-sum", :value="sum", :readonly="true")
</template>
<script>
import Decimal from 'decimal.js'
const priceFormat = new Intl.NumberFormat('de-DE', {minimumFractionDigits: 2, maximumFractionDigits: 2})

export default {
	components: {},
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
		price: {
			get () {
				return priceFormat.format(this.value.price)
			},
			set (v) {
				try {
					this.value.price = new Decimal(v.replace(',', '.'))
				} catch (e) {

				}
			}
		},
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
