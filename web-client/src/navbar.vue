<template lang="jade">
nav
	.nav-inner
		bunt-tabs(:active-tab="activeTab")
			bunt-tab(header="Artikel", id="products", @selected="tabSelected")
			bunt-tab(header="Lieferanten", id="suppliers", @selected="tabSelected")
			bunt-tab(header="Kunden", id="customers", @selected="tabSelected")
			bunt-tab(header="Verkaufshistorie", id="sales", @selected="tabSelected")
			bunt-tab(header="Gutscheine", id="coupons", @selected="tabSelected")
			//- bunt-tab(header="Statistiken", id="statistics", @selected="$router.go('/statistics')")

		//- ui-switch.toggle-cost(label="EK anzeigen", :value.sync="costVisible")
</template>
<script>
import globals from 'lib/globals'

export default {
	components: {},
	data() {
		return {
			selectedCell: null,
			costVisible: false
		}
	},
	computed: {
		activeTab () {
			return this.$route.name.split(':', 1)[0]
		}
	},
	methods: {
		tabSelected (id) {
			if (this.$route.name.split(':', 1)[0] === id)
				return // HACK prevent programatic select changing route, see computed.activeTab
			this.$router.replace({name: id, params: this.$route.params})
		}
	},
	watch: {
		costVisible (makeVisible) {
			// using watch here is a tad wrong, but keen wants bidirectional values…
			globals.costVisible = makeVisible
		}
	}
}
</script>
<style lang="stylus">
@import '~_settings'
nav
	card()
	.nav-inner
		width 1200px
		margin 0 auto
		display flex
	.bunt-tabs
		width: auto
		tabs-style(
			background-color: transparent,
			color: $clr-secondary-text-light,
			active-color: $clr-primary-text-light,
			indicator-color: $crisp-primary
		)
		margin-bottom: 0
	.toggle-cost
		flex 1
		align-self center
		.ui-switch-label-text
			white-space nowrap

</style>
