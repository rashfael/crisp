Model = require 'models/base/model'
Collection = require 'models/base/collection'

module.exports.Customer = class Customer extends Model
	idAttribute: '_id'
	urlRoot: '/api/v2/customers'
	new: false

	isNew: => @new or not @has @idAttribute

module.exports.Customers = class Customers extends Collection
	model: Customer
	url: '/api/v2/customers'

	constructor: ->
		@metadata = new Model()
		super

	parse: (response) =>
		@metadata.set response.metadata
		return response.items
