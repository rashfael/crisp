<template lang="jade">
edit.content(:supplier="supplier")
</template>
<script>
import Edit from './edit'

export default {
	components: {Edit},
	props: {
		supplier: Object
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
