<template lang="jade">
#v-app
	template(v-if="ready")
	navbar(v-if="$route.name !== 'pos'")
	router-view
</template>
<script>
import { mapGetters } from 'vuex'
import Navbar from './navbar'
import './styles/style.styl'

export default {
	components: { Navbar },
	created () {
		this.$store.dispatch('fetch-globals')
	},
	computed: {
		...mapGetters(['ready'])
	}
}
</script>
<style lang="stylus">
</style>
