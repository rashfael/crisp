<template lang="jade">
.item
	.actions
		bunt-icon-button(@click="$emit('remove')") close
	.article-id {{ value.productId }}
	.article-name {{ value.name }}
	cell-decimal-input.item-price(name="item-price", v-model="price", :fixed="2")
	cell-decimal-input.item-discount(name="item-discount", v-model="discount")
	input.item-amount(name="item-amount", v-model.number="amount")
	input.item-sum(name="item-sum", :value="sum")
</template>
<script>
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
		price: {
			get () {
				return this.value.price.sub(this.value.price.mul(this.value.discount))
			},
			set (discountedPrice) {
				try {
					if (this.value.price.isZero() && this.value.product && this.value.product.sale === 0) {
						this.value.price = discountedPrice
					} else {
						this.value.discount = this.value.price.sub(discountedPrice).div(this.value.price)
					}
				} catch (e) {

				}
			}
		},
		discount: {
			get () {
				return this.value.discount.mul(100)
			},
			set (v) {
				try {
					this.value.discount = v.div(100)
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
@import '~_settings'

#pos .item
	height: 48px
	display: flex
	align-items: center
	input
		border: 0
		text-align: right
		font-weight: 600
		width: 80px
		align-self: stretch
		font-size: 20px
		&:focus
			background-color: $clr-primary
			color: $clr-primary-text-dark

	.article-id, .article-name, .item-sum


	.item-price, .item-discount, .item-amount, .item-sum
		input
			text-align: right

	.article-id .label-input-container
		padding-left: 8px
	.item-sum .label-input-container
		padding-right: 8px

</style>
