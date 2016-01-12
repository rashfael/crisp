mediator = require 'mediator'
Controller = require 'controllers/base/controller'

{Product, Products} = require 'models/products'

ProductsListView = require 'views/products/list-view'
ProductsNewView = require 'views/products/new-view'
PaginationView = require 'views/pagination-view'

module.exports = class ProductsController extends Controller

	index: (params) ->

		products = new Products()
		products.fetch reset: true
		@view = new ProductsListView
			region: 'main'
			collection: products

		@view.subview 'pagination', new PaginationView
			model: products.metadata
			region: 'pagination'

		@subscribeEvent 'pagination:page', (page) =>
			console.log 'load', page
			products.fetch
				reset: true
				data:
					skip: page * 100

		@subscribeEvent '!search', (query) =>
			console.log query
			products.fetch
				reset: true
				data:
					search: query

	new: (params) =>
		@view = new ProductsNewView
			region: 'main'

		@listenTo @view, 'new', (product) ->
			console.log product
			product.new = true
			product.save()
