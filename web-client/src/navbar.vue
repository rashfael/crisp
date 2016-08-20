<template lang="jade">
nav
	.nav-inner
		ui-tabs(:active-tab="$route.name")
			ui-tab(header="Artikel", id="products", @selected="$router.go('/products')")
			ui-tab(header="Lieferanten", id="suppliers", @selected="$router.go('/suppliers')")
			ui-tab(header="Kunden", id="customers", @selected="$router.go('/customers')")
			ui-tab(header="Verkaufshistorie", id="sales", @selected="$router.go('/sales')")
			ui-tab(header="Gutscheine", id="coupons", @selected="$router.go('/coupons')")
			ui-tab(header="Statistiken", id="statistics", @selected="$router.go('/statistics')")

		ui-switch.toggle-cost(label="EK anzeigen", :value.sync="costVisible")
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
	methods: {

	},
	watch: {
		costVisible(makeVisible) {
			// using watch here is a tad wrong, but keen wants bidirectional values…
			globals.costVisible = makeVisible
		}
	}
}
</script>
<style lang="stylus">
@import '~_settings'
nav
	.nav-inner
		width 1200px
		margin 0 auto
		display flex
	.ui-tabs
		margin-bottom 0
	.ui-tabs-header.background-color-default
		background-color clr-white
	.ui-tabs-header-items.text-color-black
		color clr-disabled-text-light

	.ui-tabs-header-items.text-color-active-primary .ui-tab-header-item.active
		color clr-primary-text-light

	.ui-tabs-active-tab-indicator.color-primary
		background-color crisp-primary
	.ui-tabs-body
		display none
	.toggle-cost
		flex 1
		align-self center
		.ui-switch-label-text
			white-space nowrap

</style>
