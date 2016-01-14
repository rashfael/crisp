HomeController = require 'controllers/home-controller'
HelpController = require 'controllers/help-controller'
ProductsController = require 'controllers/products'
# Application routes.
module.exports = (match) ->
	match '', {controller: HomeController, action: 'index'}
	match 'help', {controller: HelpController, action: 'index'}
	match 'products', {controller: ProductsController, action: 'index'}
	match 'products/new', {controller: ProductsController, action: 'new'}
	match 'products/:id', {controller: ProductsController, action: 'item'}
