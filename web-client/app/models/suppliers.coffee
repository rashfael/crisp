Model = require 'models/base/model'
Collection = require 'models/base/collection'

module.exports.Supplier = class Supplier extends Model
	idAttribute: '_id'
	urlRoot: '/api/v2/suppliers'
	new: false

	isNew: => @new or not @has @idAttribute

module.exports.Suppliers = class Suppliers extends Collection
	model: Supplier
	url: '/api/v2/suppliers'

	constructor: ->
		@metadata = new Model()
		super

	parse: (response) =>
		@metadata.set response.metadata
		return response.items
