<template lang="jade">
.product-details.details

	edit(:product="product", :is-new="true")
</template>
<script>
import api from 'lib/api'
import Edit from './edit'
import Decimal from 'decimal.js'

export default {
	components: {Edit},
	data() {
		return {
			product: {
				_id: '',
				productGroupId: 0,
				supplierId: 0,
				supplier_product_id: '',
				name: '',
				printerline1: '',
				printerline2: '',
				cost: new Decimal(),
				sale: new Decimal()
			}
		}
	}
}
</script>
<style lang="stylus">
</style>
