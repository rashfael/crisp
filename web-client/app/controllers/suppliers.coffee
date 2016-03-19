async = require 'async'
$ = require 'jquery'
mediator = require 'mediator'
Controller = require 'controllers/base/controller'

{Supplier, Suppliers} = require 'models/suppliers'

SuppliersListView = require 'views/suppliers/list-view'
SuppliersItemView = require 'views/suppliers/item-view'
SuppliersNewView = require 'views/suppliers/new-view'
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

		@subscribeEvent 'row:clicked', (item) =>
			@redirectTo {controller: SuppliersController, action: 'item', params: {id: item.get '_id'}}

	new: (params) =>
		@view = new SuppliersNewView
			region: 'main'

		@listenTo @view, 'new', (raw) ->
			item = new Supplier raw
			item.new = true
			item.save().done( =>
				@redirectTo 'suppliers'
			).fail (err) ->
				console.err err

	item: (params) =>
		item = new Supplier
			_id: params.id

		async.parallel [
				(cb) -> item.fetch success: -> cb null, {}
			,
				(cb) -> $.getJSON "/api/v2/suppliers/#{params.id}/statistics", (data) -> cb null, data
			], (err, data) =>
				item.set 'statistics', data[1]
				@view = new SuppliersItemView
					region: 'main'
					model: item
				@listenTo @view, 'save', (raw) ->
					item.save(raw).done( =>
						@redirectTo 'suppliers'
					).fail (err) ->
						console.err err
