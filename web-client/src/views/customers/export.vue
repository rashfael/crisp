<template lang="jade">
#customers-export
	form(@submit.prevent="download")
		ui-select(label="Geburtstag", name="birthday_month", :options="birthdayOptions", :default="birthdayOptions[0]", :value.sync="birthday")
		ui-switch.email(label="Email", :value.sync="hasEmail")
		button(type="submit") Export
	a.download-link(v-el:download-link)
</template>

<script>
import api from 'lib/api'

export default {
	data() {
		return {
			hasEmail: false,
			birthday: {},
			birthdayOptions: [
				{value: null, text: 'Alle'},
				{value: 1, text: 'Januar'},
				{value: 2, text: 'Februar'},
				{value: 3, text: 'März'},
				{value: 4, text: 'April'},
				{value: 5, text: 'Mai'},
				{value: 6, text: 'Juni'},
				{value: 7, text: 'Juli'},
				{value: 8, text: 'August'},
				{value: 9, text: 'September'},
				{value: 10, text: 'Oktober'},
				{value: 11, text: 'November'},
				{value: 12, text: 'Dezember'},
			]
		}
	},
	ready() {},
	attached() {},
	methods: {
		download () {
			api.customers.csvExport(this.birthday.value, this.hasEmail).then((result) => {
				const blob = new Blob([result.csv], { type: 'text/csv' })
				const url = URL.createObjectURL(blob)
				const link = this.$els.downloadLink
				link.setAttribute('href', url);
				link.setAttribute('download', 'kunden.csv');
				link.click();
				URL.revokeObjectURL(url);
			})
		}
	},
	components: {}
}
</script>
<style lang="stylus">
@import '~_settings'
@import '~_ui'

#customers-export
	flex 1 0
	display flex
	max-width content-width
	margin 36px auto 0
	form
		display flex
		align-items center
	.ui-select
		width 360px

	.ui-switch
		padding 0 32px
	button
		button(crisp-primary)
		line-height 36px
		margin 8px
		padding 0 22px
		height 36px
</style>
