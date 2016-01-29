$ = require 'jquery'
_ = require 'lodash'

class Translations
	dateFormat: "DD. MM. YYYY"
	suppliers: []
	suppliersMap: {}
	productGroups: []
	productGroupsMap: {}

	fetch: (cb) =>
		$.when($.getJSON('/api/v2/suppliers'), $.getJSON('/api/v2/product-groups')).then (rawSuppliers, rawProductGroups) =>
			@suppliers = rawSuppliers[0].items
			@suppliersMap = _.keyBy @suppliers, '_id'
			@productGroups = rawProductGroups[0].items
			@productGroupsMap = _.keyBy @productGroups, '_id'
			cb()
		, (err) => console.error err

module.exports = new Translations()
