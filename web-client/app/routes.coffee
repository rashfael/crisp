HomeController = require 'controllers/home-controller'
HelpController = require 'controllers/help-controller'
ProductsController = require 'controllers/products'
SuppliersController = require 'controllers/suppliers'
CustomersController = require 'controllers/customers'
SalesController = require 'controllers/sales'


# Application routes.
module.exports = (match) ->
	match '', {controller: HomeController, action: 'index'}
	match 'help', {controller: HelpController, action: 'index'}

	match 'customers', {controller: CustomersController, action: 'index'}

	match 'products', {controller: ProductsController, action: 'index', name: 'products'}
	match 'products/new', {controller: ProductsController, action: 'new'}
	match 'products/:id', {controller: ProductsController, action: 'item'}

	match 'sales', {controller: SalesController, action: 'index'}
	match 'sales/:id', {controller: SalesController, action: 'item'}

	match 'suppliers', {controller: SuppliersController, action: 'index'}
