<template lang="jade">
edit.content(:product="product")

</template>
<script>
import Edit from './edit'

export default {
	components: {Edit},
	props: {
		product: Object
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
	methods: {

	}
}
</script>
<style lang="stylus">
</style>
