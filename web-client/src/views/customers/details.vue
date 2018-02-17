<template lang="jade">
edit(:customer="customer")
</template>
<script>
import Edit from './edit'

export default {
	components: {Edit},
	props: {
		customer: Object
	},
	data () {
		return {
		}
	},
	computed: {},
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
