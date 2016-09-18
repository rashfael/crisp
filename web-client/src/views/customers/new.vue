<template lang="jade">
.customer-details.details
	edit(:customer="customer", :new="true")
</template>
<script>
import api from 'lib/api'
import Edit from './edit'

export default {
	components: {Edit},
	data() {
		return {
			customer: {
				_id: '',
				name: '',
				forename: '',
				street: '',
				zip: '',
				place: '',
				tel: '',
				email: '',
				birthday: '',
				customerSince: '',
				notes: ''
			}
		}
	}
}
</script>
<style lang="stylus">

</style>
