<template lang="jade">
#pos
	.mode-scan(v-if="mode === 'scan'")
		.meta-pane
			ultrasearch(@search="onSearch", :results="ultraresults", @selected="onSelect")
			.customer
				i.material-icons account_circle
				.customer-name {{ customer ? customer.forename + ' ' + customer.name : 'Laufkunde' }}
		.item-pane
			.items
				.item-header
					span.article-id #
					span.article-name Beschreibung
					span.item-price Preis
					span.item-discount Rabatt
					span.item-amount Menge
					span.item-sum Summe
				template(v-for="item in items")
					coupon-item(v-if="item.type === 'coupon'", :value="item")
					sale-item(v-else, :value="item")
			.finalize
				.actions
					bunt-button#btn-add-coupon(@click.native="addCoupon") Neuer Gutschein
					bunt-button#btn-pay(@click.native="mode = 'pay'") bezahlen
				.totals
					.subtotal {{ subtotal | currency }}
					percentage-input.global-discount(name="global-discount", v-model="globalDiscount")
					.total {{ total | currency  }}
	.mode-return(v-if="mode === 'return'")
		bunt-icon-button#btn-back(@click.native="mode = 'scan'") arrow_back
		.items
			.item-header
				span.item-selected ~
				span.article-id #
				span.article-name Beschreibung
				span.item-discount Rabatt
				span.item-amount Menge
				span.item-sum Summe
			.item(v-for="item of returnSale.sale_items", :class="{selected: returnSale.returningItems.includes(item)}", @click="selectReturnItem(item)")
				bunt-checkbox(:value="returnSale.returningItems.includes(item)", name="returnItemSelection").item-selected
				span.article-id {{ item.product.id }}
				span.article-name {{ item.product.name }}
				span.item-discount {{ item.discount | percentage }}
				span.item-amount {{ item.amount }}
				span.item-price {{ item.price | currency }}
		bunt-button#return-final(@click.native="returnSelected") ausgewählte Artikel zurückgeben
	.mode-pay(v-if="mode === 'pay'")
		bunt-icon-button#btn-back(@click.native="mode = 'scan'") arrow_back
		.subtotal
			h2 Vor Rabatt:
			h1 {{ subtotal | currency }} €
		.discount
			h2 Rabatt:
			percentage-input.global-discount(name="global-discount", v-model="globalDiscount")
		.total
			h2 Endbetrag:
			h1 {{ total | currency }} €
		.actions
			bunt-button#pay-bar(icon="attach_money", :class="{active: paymentMethod === 'cash'}", @click.native="paymentMethod = 'cash'") bar
			bunt-button#pay-ec(icon="credit_card", :class="{active: paymentMethod === 'card'}", @click.native="paymentMethod = 'card'") ec
		.actions
			bunt-button#pay-final(@click.native="send", :disabled="!paymentMethod") Bezahlt
</template>
<script>
import Decimal from 'decimal.js'
import SaleItem from './sale-item'
import CouponItem from './coupon-item'
import Ultrasearch from './ultrasearch'
import api from 'lib/api'

export default {
	components: { CouponItem, SaleItem, Ultrasearch },
	data () {
		return {
			mode: 'scan', // 'scan', 'return', 'pay'
			ultraresults: {
				products: [],
				customers: [],
				sales: [],
				coupons: []
			},
			customer: null,
			returnSale: null,
			items: [],
			globalDiscount: new Decimal(0),
			paymentMethod: null
		}
	},
	computed: {
		subtotal () {
			return this.items.reduce((acc, item) => {
				return acc.add(item.price.sub(item.price.mul(item.discount)).mul(item.amount))
			}, new Decimal(0))
		},
		total () {
			return this.subtotal.sub(this.subtotal.mul(this.globalDiscount))
		}
	},
	created () {},
	mounted () {
		this.$nextTick(() => {
		})
	},
	methods: {
		onSearch (search) {
			if (search === '') return
			this.ultraresults = {
				products: [],
				customers: [],
				sales: [],
				coupons: []
			}
			Promise.all([api.products.list(search), api.customers.list(search), api.sales.list(search), api.coupons.list(search)]).then(([products, customers, sales, coupons]) => {
				this.ultraresults = {
					products: products.results,
					customers: customers.results,
					sales: sales.results,
					coupons: coupons.results
				}
			})
		},
		onSelect ({type, object}) {
			this.ultraresults = {
				products: [],
				customers: [],
				sales: [],
				coupons: []
			}
			switch (type) {
				case 'product':
					const product = {
						type,
						productId: object.id,
						name: object.name,
						price: new Decimal(object.sale),
						discount: new Decimal(0),
						amount: 1
					}
					this.items.push(product)
					break
				case 'customer':
					this.customer = object
					break
				case 'sale':
					Promise.all(object.sale_items.map((item) => api.products.get(item.product))).then((products) => {
						object.sale_items.forEach((item, i) => {
							item.product = products[i]
						})
						this.$set(this, 'returnSale', object)
						this.$set(this.returnSale, 'returningItems', [])
						// this.returnSale = object
						this.mode = 'return'
					})
					break
			}
		},
		addCoupon () {
			this.items.push({
				type: 'coupon',
				price: new Decimal(0),
				discount: new Decimal(0),
				amount: 1
			})
		},
		send () {
			const sale_items = this.items.filter((item) => item.type === 'product').map((item) => ({
				product: item.productId,
				price: item.sum,
				discount: item.discount,
				amount: item.amount
			}))
			const coupon_items = this.items.filter((item) => item.type === 'coupon').map((item) => ({
				coupon: item.couponId || 0,
				value_change: item.price
			}))
			api.sales.create({
				customer: this.customer ? this.customer.id : 1,
				price: this.total,
				discount: this.globalDiscount,
				payment_method: this.paymentMethod,
				sale_items,
				coupon_items
			})
		},
		selectReturnItem (item) {
			const idx = this.returnSale.returningItems.indexOf(item)
			if (idx >= 0)
				this.returnSale.returningItems.splice(idx, 1)
			else
				this.returnSale.returningItems.push(item)
		},
		returnSelected () {
			for (const item of this.returnSale.returningItems) {
				const returnItem = {
					type: 'return',
					productId: item.product.id,
					name: `Rückgabe: '${item.product.name}'`,
					price: new Decimal(item.price).div(item.amount).mul(-1),
					discount: new Decimal(0),
					amount: item.amount,
					returnedItemId: item.id
				}
				this.items.push(returnItem)
			}
			this.mode = 'scan'
		}
	}
}
</script>
<style lang="stylus">
#pos
	display: flex
	flex: 1 1
	.actions
		.bunt-button
			margin: 16px
			height: 64px
			width: 265px
			font-size: 24px
	.items
		flex: 1 0
		display: flex
		flex-direction: column
		.item-header, .item
			display: flex

		.item-header
			height: 32px
			align-items: center
			border-bottom: 2px solid $clr-dividers-light

			> :first-child
				padding-left: 8px

			> :last-child
				padding-right: 8px

			.item-price, .item-discount, .item-amount, .item-sum
				text-align: right
		.article-id
			flex: 0 0 136px
			box-sizing: border-box

		.article-name
			flex: 1 0

		.item-price, .item-discount, .item-amount, .item-sum
			flex: 0 0 80px
	.mode-scan
		display: flex
		flex: 1 1
		.item-pane
			flex: 1 0
			display: flex
			flex-direction: column
			background-color: $clr-white

			.finalize
				height: 128px
				border-top: 2px solid $clr-dividers-light
				display: flex
				.actions
					flex: 1
					align-items: center
					display: flex
					justify-content: space-between
					#btn-pay
						button-style(color: $clr-success)
				.totals
					flex: 0 0 128px
					padding: 8px 16px
					display: flex
					flex-direction: column
					align-items: flex-end
				.subtotal, .total
					font-size: 24px
				.global-discount
					width: 48px
					margin-bottom: 4px
					input
						text-align: right
		.meta-pane
			card()
			z-index: 90
			flex: 0 0 360px
			display: flex
			flex-direction: column
			> .customer
				display: flex
				padding: 8px
				> i
					font-size: 64px
					color: $clr-blue-grey-500
				.bunt-input
					flex: 1
					margin: 8px 16px

	.mode-pay, .mode-return
		background-color: $clr-white
		flex: 1 1
		display: flex
		flex-direction: column
		justify-content: center
		align-items: center

		#btn-back
			position: absolute
			left: 16px
			top: 16px
			icon-button-style()
			height: 64px
			width: @height
			.material-icons
				font-size: 64px

	.mode-return
		.items
			width: 720px
			margin-top: 32px

			.item
				height: 48px
				align-items: center

				&.selected
					background-color: $clr-success

			.item-selected
				width: 36px
				padding-left: 8px
	.mode-pay
		.subtotal, .discount, .total
			display: flex
			align-items: baseline
			:first-child
				width: 256px
				text-align: right
				padding-right: 24px
				font-weight: 500
			:nth-child(2)
				width: 256px
				text-align: right

			.bunt-input

				input
					font-size: 24px
		.actions
			display: flex
			.bunt-button
				.material-icons
					font-size: 36px
					width: 48px


				&.active
					outline-style: solid
					outline-width: 4px
					outline-offset: 4px

			#pay-bar
				button-style(color: $clr-green)
				&.active
					outline-style: solid
					outline-width: 4px
					outline-offset: 4px
					outline-color: $clr-green
			#pay-ec
				button-style(color: $clr-blue)
				&.active
					&.active
						outline-color: $clr-blue

			#pay-final
				button-style(color: $clr-green)
				margin-top: 64px
</style>
