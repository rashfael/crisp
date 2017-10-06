<template lang="jade">
bunt-input(v-model="decimalValue", :name="name")
</template>
<script>
import Decimal from 'decimal.js'
export default {
	props: {
		value: {
			type: Decimal,
			default: new Decimal(0)
		},
		name: String
	},
	data () {
		return {
		}
	},
	computed: {
		decimalValue: {
			get () {
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
