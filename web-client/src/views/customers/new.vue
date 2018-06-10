<template lang="jade">
.customer-new.details
	edit(:customer="customer", :is-new="true")
</template>
<script>
import moment from 'moment'

import Edit from './edit'

export default {
	components: {Edit},
	data () {
		return {
			customer: {
				id: '',
				name: '',
				forename: '',
				street: '',
				zip: '',
				place: '',
				tel: '',
				email: '',
				birthday: moment(),
				customerSince: '',
				notes: ''
			}
		}
	}
}
</script>
<style lang="stylus">
.customer-new
	padding: 16px 64px
	form
		width: 520px
</style>
