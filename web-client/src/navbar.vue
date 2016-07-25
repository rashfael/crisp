<template lang="jade">
nav
	ul.nav
		li: a(v-link="'/products/'") Artikel
		li: a(href='/suppliers/') Lieferanten
		li: a(href='/customers/') Kunden
		li: a(href='/sales/') Verkaufshistorie
		li: a(href='/coupons/') Gutscheine
		li: a(href='/statistics') Statistiken
		//- li: a(href='/inventory') Inventur

	button.toggle-cost EK anzeigen
	a.settings(href='/settings'): i.fa.fa-cogs
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
</style>^
