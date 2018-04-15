<template lang="jade">
.item
	bunt-input.article-id(name="article-id", v-model="value.productId", :readonly="true")
	bunt-input.article-name(name="article-name", :value="value.name", :readonly="true")
	bunt-input.item-price(name="item-price", v-model="price")
	percentage-input.item-discount(name="item-discount", v-model="value.discount")
	bunt-input.item-amount(name="item-amount", v-model.number="amount")
	bunt-input.item-sum(name="item-sum", :value="sum")
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
				return priceFormat.format(this.value.price.sub(this.value.price.mul(this.value.discount)))
			},
			set (v) {
				try {
					const discountedPrice = new Decimal(v.replace(',', '.'))
					this.value.discount = discountedPrice.div(this.value.price)
				} catch (e) {

				}
			}
		},
		sum: {
			get () {
				const price = this.value.price.sub(this.value.price.mul(this.value.discount))
				return priceFormat.format(price.mul(this.value.amount))
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
#pos .item
	height: 48px
	.bunt-input
		margin-bottom: 0

	.article-id, .article-name, .item-sum
		.underline:after
			display: none

	.item-price, .item-discount, .item-amount, .item-sum
		input
			text-align: right

	.article-id .label-input-container
		padding-left: 8px
	.item-sum .label-input-container
		padding-right: 8px

</style>
