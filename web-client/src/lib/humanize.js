import _ from 'lodash'
import api from 'lib/api'

let humanize = {
	dateFormat: 'DD. MM. YYYY',
	priceFormat: new Intl.NumberFormat('de-DE', {minimumFractionDigits: 2, maximumFractionDigits: 2}),
	suppliersMap: {},
	productGroups: [],
	productGroupsMap: {},

	init () {
		Promise.all([api.suppliers.list(), api.productGroups.list()]).then(([rawSuppliers, rawProductGroups]) => {
			humanize.suppliers = rawSuppliers.results
			humanize.suppliersMap = _.keyBy(humanize.suppliers, '_id')
			humanize.productGroups = rawProductGroups.results
			humanize.productGroupsMap = _.keyBy(humanize.productGroups, '_id')
			return Promise.resolve()
		})
	}
}

export default humanize
