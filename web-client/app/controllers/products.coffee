mediator = require 'mediator'
Controller = require 'controllers/base/controller'

ProductsListView = require 'views/products/list-view'
ProductsNewView = require 'views/products/new-view'


module.exports = class ProductsController extends Controller

	index: (params) ->
		@view = new ProductsListView
			region: 'main'

	new: (params) ->
		@view = new ProductsNewView
			region: 'main'
