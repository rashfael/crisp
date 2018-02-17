<template lang="jade">
.product-new.details
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
				cost: new Decimal(0),
				sale: new Decimal(0)
			}
		}
	}
}
</script>
<style lang="stylus">
.product-new
	padding: 16px 64px
</style>
