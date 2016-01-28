async = require 'async'
$ = require 'jquery'
mediator = require 'mediator'
Controller = require 'controllers/base/controller'

{Supplier, Suppliers} = require 'models/suppliers'

SuppliersListView = require 'views/suppliers/list-view'
# ProductsItemView = require 'views/products/item-view'
#
# ProductsNewView = require 'views/products/new-view'
PaginationView = require 'views/pagination-view'

module.exports = class SuppliersController extends Controller

	index: (params) ->

		suppliers = new Suppliers()
		suppliers.fetch reset: true
		@view = new SuppliersListView
			region: 'main'
			collection: suppliers

		@view.subview 'pagination', new PaginationView
			model: suppliers.metadata
			region: 'pagination'

		@subscribeEvent 'pagination:page', (page) =>
			console.log 'load', page
			suppliers.fetch
				reset: true
				data:
					skip: page * 100

		@subscribeEvent '!search', (query) =>
			console.log query
			suppliers.fetch
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
