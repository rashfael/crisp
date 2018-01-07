<template lang="jade">
bunt-input(v-model="decimalValue", :name="name", :label="label")
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
					const dv = new Decimal(v.replace(',', '.'))
					this.$emit('input', dv)
				} catch (e) {

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
</style>
