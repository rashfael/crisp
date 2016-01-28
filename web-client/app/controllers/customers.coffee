async = require 'async'
$ = require 'jquery'
mediator = require 'mediator'
Controller = require 'controllers/base/controller'

{Customer, Customers} = require 'models/customers'

CustomersListView = require 'views/customers/list-view'
# ProductsItemView = require 'views/products/item-view'
#
# ProductsNewView = require 'views/products/new-view'
PaginationView = require 'views/pagination-view'

module.exports = class CustomersController extends Controller

	index: (params) ->

		customers = new Customers()
		customers.fetch reset: true
		@view = new CustomersListView
			region: 'main'
			collection: customers

		@view.subview 'pagination', new PaginationView
			model: customers.metadata
			region: 'pagination'

		@subscribeEvent 'pagination:page', (page) =>
			console.log 'load', page
			customers.fetch
				reset: true
				data:
					skip: page * 100

		@subscribeEvent '!search', (query) =>
			console.log query
			customers.fetch
				reset: true
				data:
					search: query

		# @subscribeEvent 'row:clicked', (product) =>
		# 	@redirectTo {controller: ProductsController, action: 'item', params: {id: product.get '_id'}}

	# new: (params) =>
	# 	@view = new ProductsNewView
	# 		region: 'main'
	#
	# 	@listenTo @view, 'new', (product) ->
	# 		console.log product
	# 		product.new = true
	# 		product.save()
	#
	# 	@listenTo @view, 'generateId', ->
	# 		$.getJSON '/api/v2/products/generate-id', (data) =>
	# 			console.log 'generated id', data
	# 			@view.setId data
	#
	# item: (params) =>
	# 	product = new Product
	# 		_id: params.id
	#
	# 	async.parallel [
	# 			(cb) -> product.fetch success: -> cb null, {}
	# 		,
	# 			(cb) -> $.getJSON "/api/v2/products/#{params.id}/history", (data) -> cb null, data
	# 		], (err, data) ->
	# 			product.set 'history', data[1]
	# 			@view = new ProductsItemView
	# 				region: 'main'
	# 				model: product
