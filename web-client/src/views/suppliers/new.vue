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
				name2: '',
				street: '',
				zip: '',
				place: '',
				tel: '',
				tel2: '',
				fax: '',
				email: '',
				notes: ''
			}
		}
	}
}
</script>
<style lang="stylus">
@import "~_settings"

.supplier-details
	card()
	width 1200px
	margin 0 auto
</style>
