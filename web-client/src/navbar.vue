<template lang="jade">
nav
	ul.nav
		li: a(v-link="'/products/'") Artikel
		li: a(v-link="'/suppliers/'") Lieferanten
		li: a(v-link="'/customers/'") Kunden
		li: a(v-link="'/sales/'") Verkaufshistorie
		li: a(v-link="'/coupons/'") Gutscheine
		li: a(v-link="'/statistics'") Statistiken

	button.toggle-cost EK anzeigen
</template>
<script>
export default {
	components: {},
	data() {
		return {
			selectedCell: null
		}
	},
	methods: {

	},
	ready() {

	},
	events: {
		'cell-selected'(data) {
			this.selectedCell = data
		}
	}
}
</script>
<style lang="stylus">
</style>
