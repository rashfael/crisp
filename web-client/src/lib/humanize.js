import _ from 'lodash'
import api from 'lib/api'

let humanize = {
	dateFormat: "DD. MM. YYYY",
	suppliers: [],
	suppliersMap: {},
	productGroups: [],
	productGroupsMap: {},

	fetch() {
		Promise.all([api.suppliers.list(), api.productGroups.list()]).then(([rawSuppliers, rawProductGroups]) => {
			humanize.suppliers = rawSuppliers.items
			humanize.suppliersMap = _.keyBy(humanize.suppliers, '_id')
			humanize.productGroups = rawProductGroups.items
			humanize.productGroupsMap = _.keyBy(humanize.productGroups, '_id')
			return Promise.resolve()
		})
	}
}

export default humanize
