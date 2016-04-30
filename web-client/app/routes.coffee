HomeController = require 'controllers/home-controller'
HelpController = require 'controllers/help-controller'
ProductsController = require 'controllers/products'
SuppliersController = require 'controllers/suppliers'
CouponsController = require 'controllers/coupons'
CustomersController = require 'controllers/customers'
SalesController = require 'controllers/sales'
StatisticsController = require 'controllers/statistics'



# Application routes.
module.exports = (match) ->
	match '', {controller: HomeController, action: 'index'}
	match 'help', {controller: HelpController, action: 'index'}

	match 'coupons', {controller: CouponsController, action: 'index'}
	match 'coupons/:id', {controller: CouponsController, action: 'item'}

	match 'customers', {controller: CustomersController, action: 'index'}
	match 'customers/new', {controller: CustomersController, action: 'new'}
	match 'customers/:id', {controller: CustomersController, action: 'item'}

	match 'products', {controller: ProductsController, action: 'index', name: 'products'}
	match 'products/new', {controller: ProductsController, action: 'new'}
	match 'products/:id', {controller: ProductsController, action: 'item', name: 'product'}

	match 'sales', {controller: SalesController, action: 'index'}
	match 'sales/:id', {controller: SalesController, action: 'item'}

	match 'suppliers', {controller: SuppliersController, action: 'index'}
	match 'suppliers/new', {controller: SuppliersController, action: 'new'}
	match 'suppliers/:id', {controller: SuppliersController, action: 'item'}

	match 'statistics', {controller: StatisticsController, action: 'index'}
