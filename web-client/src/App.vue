<template lang="jade">
#v-app
	navbar
	router-view
</template>
<script>
import humanize from 'lib/humanize'
import Navbar from './navbar'
import './styles/style.styl'

export default {
	components: { Navbar },
	created () {
		humanize.init()
	},
}
</script>
<style lang="stylus">
</style>
