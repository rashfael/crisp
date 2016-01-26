$ = require 'jquery'
_ = require 'lodash'

class Translations
	suppliers: []
	suppliersMap: {}

	fetch: (cb) =>
		$.when($.getJSON('/api/v2/suppliers')).then (values) =>
			@suppliers = values.items
			@suppliersMap = _.keyBy @suppliers, '_id'
			cb()
		, (err) => console.error err

module.exports = new Translations()
