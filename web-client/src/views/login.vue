<template lang="jade">
#login
	.wrapper
		h1 crisp
		h2 v4.beta

		form(@submit.prevent="submit")
			input(name="username", v-model="username", placeholder="Benutzername")
			input(name="password", v-model="password", placeholder="Passwort", type="password")
			button(type="submit") Login
</template>
<script>
import api from 'lib/api'
import humanize from 'lib/humanize'

export default {
	data() {
		return {
			username: '',
			password: ''
		}
	},
	methods: {
		submit() {
			// copypasta humanize init
			api.auth.login(this.username, this.password).then(humanize.fetch).then(() => this.$router.go('/'))
		}
	}
}
</script>
<style lang="stylus">
@import "~_settings"
@import "~_ui"

#login
	display flex
	justify-content center
	text-align center
	padding-top 128px
	h1
		font-size 72px
		line-height	1em
		font-weight 100
		margin 0
		letter-spacing 24px
		margin-left 24px
	h2
		color clr-secondary-text-light
		font-weight 300
		font-size 16px
		font-family "Roboto Mono"
		margin 8px 0 32px 0
	form
		display flex
		flex-direction column
		align-items center
		input
			input()
			width 150px
			margin-bottom 1rem
		button
			button()

</style>
