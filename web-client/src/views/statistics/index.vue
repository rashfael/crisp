<template lang="jade">
.statistics
	input#daterangepicker(type="text", v-el:daterangepicker)
	table
		template(v-for="(supplierId, supplier) in suppliers")
			tr.supplier
				th {{ humanize.suppliersMap[supplierId].name }}
				th {{ supplier.value.amount }}
				th {{ supplier.value.sum/100 | currency }}
			tr.product(v-for="product in supplier.products")
				td {{ product.productId }}
				td {{ product.value.amount }}
				td {{ product.value.sum/100 | currency }}

</template>
<script>
import api from 'lib/api'
import $ from 'jquery'
import _ from 'lodash'
import 'daterangepicker'
import 'daterangepicker/daterangepicker-bs3.css'
import moment from 'moment'
import './index.styl'
import humanize from 'lib/humanize'


export default {
	data() {
		return {
			startDate: moment().startOf('day'),
			endDate: moment().startOf('day'),
			suppliers: [],
			humanize
		}
	},
	ready() {
		$(this.$els.daterangepicker).daterangepicker({
			locale: {
				format: 'DD.MM.YYYY'
			},
			showDropdowns: true,
			autoApply: true,
			ranges: {
				'Heute': [moment(), moment()],
				'Gestern': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
				'Letzte 7 Tage': [moment().subtract(6, 'days'), moment()],
				'Letzte 30 Tage': [moment().subtract(29, 'days'), moment()],
				'Dieser Monat': [moment().startOf('month'), moment().endOf('month')],
				'Letzter Monat': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')],
			}
		}
		, (start, end) => {
			this.startDate = start
			this.endDate = end
			this.loadStatistics()
		})
	},
	methods: {
		loadStatistics() {
			api.statistics.supplierArticleProfit(this.startDate, this.endDate).then((data) => {
				let suppliers = {}
				for(let supplierArticle of data) {
					let supplierId = supplierArticle._id.supplierId
					let productId = supplierArticle._id.productId
					let value = supplierArticle.value
					if(!(supplierId in suppliers))
						suppliers[supplierId] = {products: [], value: {amount: 0, sum: 0}}
					suppliers[supplierId].products.push({productId, value})
					suppliers[supplierId].value.amount += value.amount
					suppliers[supplierId].value.sum += value.sum
				}

				this.suppliers = suppliers
			})
		}
	}
}
</script>
<style lang="stylus">
@import '~_ui'

.statistics
	width 1200px
	margin 0 auto
	card()
	table
		table()

		.supplier
			border-bottom-width 2px
			border-top border-separator()
			border-top-width 2px
			background-color clr-grey-100

</style>
