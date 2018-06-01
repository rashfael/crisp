<template lang="jade">
#pos
	.mode-scan(v-if="mode === 'scan'")
		.meta-pane
			ultrasearch(ref="ultrasearch", @search="onSearch", :results="ultraresults", @selected="onSelect")
			.customer
				.customer-name
					i.material-icons account_circle
					span {{ customer ? customer.forename + ' ' + customer.name : 'Laufkunde' }}
				p.customer-notes(v-if="customer") {{ customer.notes }}
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
				span.article-id {{ item.product }}
				span.article-name {{ item.product_name }}
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
			bunt-button#pay-ec(icon="credit_card", :class="{active: paymentMethod === 'ec'}", @click.native="paymentMethod = 'ec'") ec
		.actions
			bunt-button#pay-final(@click.native="send", :disabled="!paymentMethod") Bezahlt
	.mode-postpay(v-if="mode === 'postpay'")
		.actions
			bunt-button#pay-final(@click="resetState") Neuer Einkauf
		h1 Einkauf erfolgreich
		.new-coupons(v-if="newCoupons.length > 0")
			h2 Gekaufte Gutscheine:
			.header
				.coupon-number Nummer
				.value Wert
			.new-coupon(v-for="couponItem in newCoupons")
				.coupon-number {{ couponItem.coupon }}
				.value {{ couponItem.value_change | currency }}


</template>
<script>
import Decimal from 'decimal.js'
import SaleItem from './sale-item'
import CouponItem from './coupon-item'
import Ultrasearch from './ultrasearch'
import api from 'lib/api'
import ioApi from 'lib/api/io'

export default {
	components: { CouponItem, SaleItem, Ultrasearch },
	data () {
		return {
			mode: 'scan', // 'scan', 'return', 'pay', 'postpay'
			ultrasearch: null,
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
			paymentMethod: null,
			postpaySale: null
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
		},
		newCoupons () {
			if (!this.postpaySale) return []
			return this.postpaySale.coupon_items.filter((item) => item.value_change > 0)
		}
	},
	created () {},
	mounted () {
		this.$nextTick(() => {
			document.addEventListener('keydown', this.onGlobalKeypress)
		})
	},
	destroyed () {
		document.removeEventListener('keydown', this.onGlobalKeypress)
	},
	methods: {
		onGlobalKeypress (event) {
			// STX perhaps?
			if (event.shiftKey && event.ctrlKey && event.key === 'B') {
				this.$refs.ultrasearch.focus()
			}
		},
		onSearch (search) {
			if (search === '') return
			this.ultrasearch = search
			this.ultraresults = {
				products: [],
				customers: [],
				sales: [],
				coupons: []
			}
			Promise.all([api.products.list(search), api.customers.list(search), api.sales.list(search), api.coupons.list(search)]).then(([products, customers, sales, coupons]) => {
				if (this.ultrasearch !== search) return
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
						amount: 1,
						product: object
					}
					this.items.push(product)
					break
				case 'coupon':
					let price = new Decimal(-1 * Math.max(0, object.changes.reduce((acc, val) => acc += val.value_change, 0)))
					if (object.id === 101005) {
						price = new Decimal(0)
					}
					const coupon = {
						type,
						price,
						discount: new Decimal(0),
						amount: 1,
						coupon: object
					}
					this.items.push(coupon)
					break
				case 'customer':
					this.customer = object
					this.globalDiscount = object.id === 1 ? new Decimal(0) : new Decimal(0.05)
					break
				case 'sale':
					this.$set(this, 'returnSale', object)
					this.$set(this.returnSale, 'returningItems', [])
					// this.returnSale = object
					this.mode = 'return'
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
			const saleItems = this.items.filter((item) => item.type === 'product').map((item) => ({
				product: item.productId,
				price: item.price.sub(item.price.mul(item.discount)).toDecimalPlaces(2),
				discount: item.discount.toDecimalPlaces(2),
				amount: item.amount
			}))
			const couponItems = this.items.filter((item) => item.type === 'coupon').map((item) => ({
				coupon: item.couponId || 0,
				value_change: item.price.toDecimalPlaces(2)
			}))
			const returnItems = this.items.filter((item) => item.type === 'return').map((item) => ({
				returned_item: item.returnedItemId,
				price: item.price.toDecimalPlaces(2),
				amount: item.amount
			}))
			api.sales.create({
				customer: this.customer ? this.customer.id : 1,
				price: this.total.toDecimalPlaces(2),
				discount: this.globalDiscount.toDecimalPlaces(2),
				payment_method: this.paymentMethod,
				sale_items: saleItems,
				coupon_items: couponItems,
				return_items: returnItems
			}).then((sale) => {
				this.postpaySale = sale
				ioApi.print.sale(sale)
				this.mode = 'postpay'
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
					productId: item.product,
					name: `Rückgabe: '${item.product_name}'`,
					price: new Decimal(item.price).div(item.amount).mul(-1),
					discount: new Decimal(0),
					amount: item.amount,
					returnedItemId: item.id
				}
				this.items.push(returnItem)
			}
			this.mode = 'scan'
		},
		resetState () {
			Object.assign(this.$data, this.$options.data())
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

			> :first-child
				padding-left: 8px

			> :last-child
				padding-right: 8px

			.item-price, .item-discount, .item-amount, .item-sum
				text-align: right

		.item-header
			height: 32px
			align-items: center
			border-bottom: 2px solid $clr-dividers-light


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
					justify-content: flex-end
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
				flex-direction: column
				.customer-name
					display: flex
					align-items: center
					font-size: 24px
					> i
						font-size: 64px
						color: $clr-blue-grey-500
				.bunt-input
					flex: 1
					margin: 8px 16px

	.mode-pay, .mode-return, .mode-postpay
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
	.mode-postpay
		.actions
			position: absolute
			left: 16px
			top: 16px
			.bunt-button
				button-style(color: $clr-green)

		.new-coupons
			display: flex
			flex-direction: column
			font-size: 24px

			.header, .new-coupon
				display: flex

				> *
					flex: 1
				.value
					text-align: right

</style>
