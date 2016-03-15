async = require 'async'
$ = require 'jquery'
mediator = require 'mediator'
Controller = require 'controllers/base/controller'

{Sale, Sales} = require 'models/sales'

SalesListView = require 'views/sales/list-view'
SaleItemView = require 'views/sales/item-view'


PaginationView = require 'views/pagination-view'

module.exports = class SalesController extends Controller

	index: (params) ->

		sales = new Sales()
		sales.fetch reset: true
		@view = new SalesListView
			region: 'main'
			collection: sales

		@view.subview 'pagination', new PaginationView
			model: sales.metadata
			region: 'pagination'

		@subscribeEvent 'pagination:page', (page) =>
			console.log 'load', page
			sales.fetch
				reset: true
				data:
					skip: page * 100

		@subscribeEvent '!search', (query) =>
			console.log query
			sales.fetch
				reset: true
				data:
					search: query

		@subscribeEvent 'row:clicked', (sale) =>
			@redirectTo {controller: SalesController, action: 'item', params: {id: sale.get '_id'}}

	item: (params) =>
		sale = new Sale
			_id: params.id
		sale.fetch success: =>
			@view = new SaleItemView
				region: 'main'
				model: sale
		# async.parallel [
		# 		(cb) -> product.fetch success: -> cb null, {}
		# 	,
		# 		(cb) -> $.getJSON "/api/v2/products/#{params.id}/history", (data) -> cb null, data
		# 	], (err, data) ->
		# 		product.set 'history', data[1]
		# 		@view = new ProductsItemView
		# 			region: 'main'
		# 			model: product
