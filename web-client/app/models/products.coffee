Model = require 'models/base/model'
Collection = require 'models/base/collection'

module.exports.Product = class Product extends Model
	idAttribute: '_id'
	urlRoot: '/api/v2/products'
	new: false

	isNew: => @new or not @has @idAttribute

module.exports.Products = class Products extends Collection
	model: Product
	url: '/api/v2/products'

	constructor: ->
		@metadata = new Model()
		super

	parse: (response) =>
		@metadata.set response.metadata
		return response.items
