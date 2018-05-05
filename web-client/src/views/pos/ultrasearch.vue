<template lang="jade">
.ultrasearch
	.bunt-input.dense(ref="searchContainer", :class="{focused: open}")
		.label-input-container
			input(type="text", ref="search", name="ultrasearch", v-model="rawSearch",
				@keyup.esc="onEscape",
				@keydown.up.prevent="typeAheadUp",
				@keydown.down.prevent="typeAheadDown",
				@keyup.enter.prevent="onEnter",
				@blur="blur",
				@focus="focus")
		.underline
		i.material-icons(v-if="!rawSearch && !open") search

	.ultraresults(v-if="results", v-show="open", @mousedown.prevent="")
		.coupons(v-if="results.coupons.length > 0")
			h6 gefundene Gutscheine
			.coupon.result(v-for="coupon in results.coupons", @click="selected('coupon', coupon)")
				.id {{ coupon.id }}
				.value  {{ coupon.changes.reduce((acc, val) => acc += val.value_change, 0) | currency }}
		.products(v-if="results.products.length > 0")
			h6 gefundene Artikel
			.product.result(v-for="product in results.products", @click="selected('product', product)")
				.id {{ product.id }}
				.name  {{ product.name }}
				.price {{ product.sale | currency }}
		.customers(v-if="results.customers.length > 0")
			h6 gefundene Kunden
			.customer.result(v-for="customer in results.customers", @click="selected('customer', customer)")
				.id {{ customer.id }}
				.name  {{ customer.forename }} {{ customer.name }}
		.sales(v-if="results.sales.length > 0")
			h6 gefundene Bons
			.customer.result(v-for="sale in results.sales", @click="selected('sale', sale)")
				.id {{ sale.id }}
				.date  {{ sale.date }}

//- ul.bunt-select-dropdown-menu(ref="dropdownMenu", v-show="open",  :style="{ 'max-height': maxHeight, 'width': width+'px' }", @mousedown.prevent.stop="")
//- 	li(v-for="option, index in filteredOptions", track-by="$index", :class="{ active: isOptionSelected(option), highlight: index === typeAheadPointer }", @mouseover="typeAheadPointer = index", @mousedown.prevent.stop="select(option)")
//- 		| {{ getOptionLabel(option) }}
//- 	li.divider(transition="fade", v-if="!filteredOptions.length")
//- 	li.text-center(transition="fade" v-if="!filteredOptions.length")
//- 		slot(name="no-options") Sorry, no matching options.
</template>
<script>
export default {
	components: {},
	props: {
		results: Object,
	},
	data () {
		return {
			open: false,
			rawSearch: '',
			selectNext: false
		}
	},
	computed: {
		hasResults () {
			if (!this.results) return false
			return Object.keys(this.results).some((key) => this.results[key].length > 0)
		},
		singleResult () {
			if (!this.results) return
			const maybeOne = []
			for (const key of Object.keys(this.results)) {
				if (this.results[key].length === 1)
					maybeOne.push({type: key.slice(0, -1), object: this.results[key][0]})
			}
			if (maybeOne.length === 1) {
				return maybeOne[0]
			}
		}
	},
	created () {},
	mounted () {
		this.$nextTick(() => {
		})
	},
	watch: {
		rawSearch (value) {
			this.selectNext = false
			this.$emit('search', value)
		},
		results () {
			if (this.selectNext) {
				this.onEnter()
			}
		}
	},
	methods: {
		focus () {
			this.open = true
		},
		blur () {
			this.open = false
		},
		/**
		 * If there is any text in the search input, remove it.
		 * Otherwise, blur the search input to close the dropdown.
		 * @return {[type]} [description]
		 */
		onEscape () {
			if (!this.rawSearch.length) {
				this.$refs.search.blur()
			} else {
				// this.deselect()
				this.rawSearch = ''
			}
		},
		onEnter () {
			if (!this.hasResults) {
				this.selectNext = true
				return
			}
			this.selectNext = false
			if (this.singleResult) {
				this.$emit('selected', this.singleResult)
				this.rawSearch = ''
				this.$refs.search.blur()
			}
		},
		selected (type, object) {
			this.$emit('selected', {
				type,
				object
			})
			this.rawSearch = ''
			this.$refs.search.blur()
		}
	}
}
</script>
<style lang="stylus">
@import '~_settings'

$ultra-height = 96px
.ultrasearch
	height: $ultra-height
	card()
	z-index: 100
	position: relative
	.bunt-input
		margin: 0
		height: $ultra-height
		padding-top: 16px

		input
			font-size: 36px
			height: 72px
			text-align: center

		i.material-icons
			color: $clr-disabled-text-light
			position: absolute
			top: 0
			bottom: 0
			width: 100%
			line-height: $ultra-height
			font-size: $ultra-height - 8px
			text-align: center
			pointer-events: none
	.ultraresults
		card()
		position: absolute
		top: $ultra-height + 6px
		left: 0
		right: 0

		h6
			padding: 0 8px
	.result
		display: flex
		height: 64px
		align-items: center
		border-top: border-separator()
		padding: 0 16px
		&:hover
			background-color: $clr-grey-200
		.id
			flex: 0 0 64px
		.name
			flex: 1 1
		.price
			flex: 0 0 64px
			text-align: right
</style>
