<template lang="jade">
.product-details.details

	edit(:product="product", :new="true")
</template>
<script>
import api from 'lib/api'
import Edit from './edit'

export default {
	components: {Edit},
	data() {
		return {
			product: {
				_id: '',
				productGroupId: 0,
				supplierId: 0,
				supplierProductId: '',
				name: '',
				printerline1: '',
				printerline2: '',
				cost: 0,
				sale: 0
			}
		}
	}
}
</script>
<style lang="stylus">
</style>
