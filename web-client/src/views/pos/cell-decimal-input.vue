<template lang="jade">
input.cell-input(:class!="{focused}", type="text", :name="name", :value="decimalValue", @focus="onFocus", @blur="onBlur($event)", @keypress.enter="$event.target.blur()")
</template>
<script>
import Decimal from 'decimal.js'
const fixedFormat = new Intl.NumberFormat('de-DE', {minimumFractionDigits: 2, maximumFractionDigits: 2})

export default {
	props: {
		value: {
			type: Decimal,
			default: new Decimal(0)
		},
		name: String,
		label: String,
		fixed: Number
	},
	data () {
		return {
			focused: false
		}
	},
	computed: {
		decimalValue: {
			get () {
				console.log('RENDER')
				return fixedFormat.format(this.value)
			},
			set (v) {
				try {
					let dv = new Decimal(v.replace(',', '.'))
					if (this.fixed) {
						dv = dv.toDecimalPlaces(this.fixed)
					}
					this.$emit('input', dv)
				} catch (e) {
					console.error(e)
				}
			}
		}
	},
	created () {},
	mounted () {
		this.$nextTick(() => {
		})
	},
	methods: {
		onFocus () {
			this.focused = true
			this.$el.select()
		},
		onBlur (event) {
			this.decimalValue = this.$el.value
			this.focused = false
		}
	}
}
</script>
<style lang="stylus">
</style>
