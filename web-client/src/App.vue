<template lang="jade">
navbar
router-view
</template>
<script>
import Navbar from './navbar'
import './styles/style.styl'
export default {
	components: { navbar: Navbar },
	replace: false
}
</script>
<style lang="stylus">
</style>
