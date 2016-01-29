Model = require 'models/base/model'
Collection = require 'models/base/collection'

module.exports.Sale = class Sale extends Model
	idAttribute: '_id'
	urlRoot: '/api/v2/sales'
	new: false

	isNew: => @new or not @has @idAttribute

module.exports.Sales = class Sales extends Collection
	model: Sale
	url: '/api/v2/sales'

	constructor: ->
		@metadata = new Model()
		super

	parse: (response) =>
		@metadata.set response.metadata
		return response.items
