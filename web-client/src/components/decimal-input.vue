<template lang="jade">
.bunt-input.dense(:class!="{focused, 'floating-label': decimalValue !== null && decimalValue.length != 0}")
	.label-input-container
		label(:for="name") {{label}}
		input(type="text", :name="name", :value="decimalValue", @focus="focused = true", @blur="onBlur($event)")
	.underline
</template>
<script>
import Decimal from 'decimal.js'
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
		fixedFormat () {
			if (this.fixed) {
				return new Intl.NumberFormat('de-DE', {minimumFractionDigits: this.fixed, maximumFractionDigits: this.fixed})
			} else {
				return new Intl.NumberFormat('de-DE')
			}
		},
		decimalValue: {
			get () {
				if (this.fixedFormat) {
					return this.fixedFormat.format(this.value)
				}
				return this.value.toString().replace('.', ',')
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
		onBlur (event) {
			this.decimalValue = event.target.value
			this.focused = false
		}
	}
}
</script>
<style lang="stylus">
</style>
