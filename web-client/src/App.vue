<template lang="jade">
#v-app
	navbar(v-if="$route.name !== 'pos'")
	router-view
</template>
<script>
import humanize from 'lib/humanize'
import Navbar from './navbar'
import './styles/style.styl'

export default {
	components: { Navbar },
	created () {
		// humanize.init()
		this.$store.dispatch('fetch-globals')
	},
}
</script>
<style lang="stylus">
</style>
