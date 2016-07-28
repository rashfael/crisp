<template lang="jade">
.supplier-details
	edit(:supplier="supplier", :new="true")
</template>
<script>
import api from 'lib/api'
import Edit from './edit'

export default {
	components: {Edit},
	data() {
		return {
			supplier: {
				_id: '',
				name: '',
				forename: '',
				street: '',
				zip: '',
				place: '',
				tel: '',
				tel2: '',
				fax: '',
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
@import '~_ui'

.supplier-details
	card()
	width 1200px
	margin 0 auto
</style>
