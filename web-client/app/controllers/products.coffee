mediator = require 'mediator'
Controller = require 'controllers/base/controller'

{Product, Products} = require 'models/products'

ProductsListView = require 'views/products/list-view'
ProductsNewView = require 'views/products/new-view'


module.exports = class ProductsController extends Controller

	index: (params) ->

		products = new Products()
		products.fetch reset: true
		@view = new ProductsListView
			region: 'main'
			collection: products

	new: (params) =>
		@view = new ProductsNewView
			region: 'main'

		@listenTo @view, 'new', (product) ->
			console.log product
			product.new = true
			product.save()
