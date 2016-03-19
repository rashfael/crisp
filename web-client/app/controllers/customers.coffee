async = require 'async'
$ = require 'jquery'
mediator = require 'mediator'
Controller = require 'controllers/base/controller'

{Customer, Customers} = require 'models/customers'

CustomersListView = require 'views/customers/list-view'
CustomersItemView = require 'views/customers/item-view'
CustomersNewView = require 'views/customers/new-view'
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

		@subscribeEvent 'row:clicked', (item) =>
			@redirectTo {controller: CustomersController, action: 'item', params: {id: item.get '_id'}}

	new: (params) =>
		@view = new CustomersNewView
			region: 'main'

		@listenTo @view, 'new', (raw) ->
			item = new Customer raw
			item.new = true
			item.save().done( =>
				@redirectTo 'suppliers'
			).fail (err) ->
				console.err err

	item: (params) =>
		item = new Customer
			_id: params.id

		async.parallel [
				(cb) -> item.fetch success: -> cb null, {}
			,
				(cb) -> $.getJSON "/api/v2/customers/#{params.id}/history", (data) -> cb null, data
			], (err, data) =>
				item.set 'history', data[1]
				@view = new CustomersItemView
					region: 'main'
					model: item
				@listenTo @view, 'save', (raw) ->
					item.save(raw).done( =>
						@redirectTo 'suppliers'
					).fail (err) ->
						console.err err
