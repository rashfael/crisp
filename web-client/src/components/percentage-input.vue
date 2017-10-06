<template lang="jade">
bunt-input(v-model="percentageValue", :name="name")
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
		percentageValue: {
			get () {
				return this.value.mul(100).toString()
			},
			set (v) {
				try {
					const dv = new Decimal(v).div(100)
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
