<template lang="jade">
.statistics.index
	.toolbar
		.actions
			.daterange
				datepicker(name="start", label="Start", v-model="startDate")
				datepicker(name="end", label="End", v-model="endDate")
	.content.list(v-scrollbar.y="")
		table
			tr.total
				th Gesamt
				th {{ totals.amount }}
				th {{ totals.sum | currency }}
			template(v-for="supplier in suppliers")
				tr.supplier
					th {{ suppliersMap[supplier.id].name }}
					th {{ supplier.amount }}
					th {{ supplier.sum | currency }}
				tr.product(v-for="product in supplier.products")
					td: router-link(:to="{name: 'products:product', params:{id: product.productId}}") {{ product.productId }} {{ product.name }}
					td {{ product.amount }}
					td {{ product.sum | currency }}

</template>
<script>
import { mapState } from 'vuex'
import api from 'lib/api'

import Datepicker from 'components/datepicker'
import moment from 'moment'

export default {
	components: { Datepicker },
	data () {
		return {
			startDate: moment().startOf('day'),
			endDate: moment().endOf('day'),
			suppliers: {},
			totals: {
				amount: 0,
				sum: 0
			}
		}
	},
	computed: {
		...mapState(['suppliersMap'])
	},
	watch: {
		startDate: 'loadStatistics',
		endDate: 'loadStatistics'
	},
	methods: {
		loadStatistics () {
			if (this.endDate.isBefore(this.startDate)) return
			api.statistics.profit(this.startDate, this.endDate).then((data) => {
				let suppliers = {}
				let totalAmount = 0
				for (let supplierArticle of data.sales) {
					let supplierId = supplierArticle.product__supplier__id
					let productId = supplierArticle.product__id
					let name = supplierArticle.product__name
					let sum = supplierArticle.price__sum
					let amount = supplierArticle.amount__sum
					if (!(supplierId in suppliers))
						suppliers[supplierId] = {id: supplierId, products: [], amount: 0, sum: 0}
					suppliers[supplierId].products.push({productId, name, sum, amount})
					suppliers[supplierId].amount += amount
					suppliers[supplierId].sum += sum
					totalAmount += amount
				}
				this.totals.amount = totalAmount
				this.totals.sum = data.totals.price__sum
				this.suppliers = suppliers
			})
		}
	}
}
</script>
<style lang="stylus">
@import "~_settings"

.statistics
	.content
		position: relative
	table
		table()
		margin-top: 52px
		border-collapse: collapse
		.supplier
			border-bottom-width 2px
			border-top border-separator()
			border-top-width 2px
			background-color $clr-grey-100

	.daterange
		display: flex
		padding: 16px

</style>
