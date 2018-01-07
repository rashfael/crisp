<template lang="jade">
.supplier-details(v-scrollbar.y="")
	edit(:supplier="supplier", :is-new="true")
</template>
<script>
import api from 'lib/api'
import Edit from './edit'

export default {
	components: {Edit},
	data() {
		return {
			supplier: {
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
	align-self: center
	position: relative
</style>
