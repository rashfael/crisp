config = require '../config'
send = require 'koa-send'

module.exports = ->
	koa = require 'koa'
	Router = require 'koa-router'
	koaBody = require('koa-body')()

	app = koa()

	routers = require './routers'

	publicRouter = Router()
	sendIndex = ->
		yield send @, 'index.html', root: config.staticFileDirectory

	publicRouter.post '/api/v2/login', koaBody, routers.auth.login


	app.use(publicRouter.routes()).use(publicRouter.allowedMethods())

	securedRouter = Router()
	securedRouter.use routers.auth.authMiddleware
	securedRouter.get '/api/v2/authenticate', routers.auth.authenticate

	if routers.customers?
		securedRouter.post '/api/v2/customers', koaBody, routers.customers.create
		securedRouter.get '/api/v2/customers', koaBody, routers.customers.list
		securedRouter.put '/api/v2/customers/:id', koaBody, routers.customers.update
		securedRouter.get '/api/v2/customers/:id', routers.customers.read
		securedRouter.get '/api/v2/customers/:id/history', routers.customers.history
		securedRouter.delete '/api/v2/customers/:id', routers.customers.delete

	if routers.products?
		securedRouter.post '/api/v2/products', koaBody, routers.products.create
		securedRouter.get '/api/v2/products', koaBody, routers.products.list
		securedRouter.put '/api/v2/products/:id', koaBody, routers.products.update
		securedRouter.get '/api/v2/products/generate-id', koaBody, routers.products.generateId
		securedRouter.get '/api/v2/products/:id', routers.products.read
		securedRouter.post '/api/v2/products/:id/arrival', koaBody, routers.products.arrival
		securedRouter.get '/api/v2/products/:id/history', routers.products.history
		securedRouter.delete '/api/v2/products/:id', routers.products.delete

	if routers.productGroups?
		securedRouter.post '/api/v2/product-groups', koaBody, routers.productGroups.create
		securedRouter.get '/api/v2/product-groups', koaBody, routers.productGroups.list
		securedRouter.put '/api/v2/product-groups/:id', koaBody, routers.productGroups.update
		securedRouter.get '/api/v2/product-groups/:id', routers.productGroups.read
		securedRouter.delete '/api/v2/product-groups/:id', routers.productGroups.delete

	if routers.suppliers?
		securedRouter.post '/api/v2/suppliers', koaBody, routers.suppliers.create
		securedRouter.get '/api/v2/suppliers', koaBody, routers.suppliers.list
		securedRouter.put '/api/v2/suppliers/:id', koaBody, routers.suppliers.update
		securedRouter.get '/api/v2/suppliers/:id', routers.suppliers.read
		securedRouter.get '/api/v2/suppliers/:id/statistics', routers.suppliers.statistics
		securedRouter.delete '/api/v2/suppliers/:id', routers.suppliers.delete

	if routers.sales?
		securedRouter.post '/api/v2/sales', koaBody, routers.sales.create
		securedRouter.get '/api/v2/sales', koaBody, routers.sales.list
		securedRouter.put '/api/v2/sales/:id', koaBody, routers.sales.update
		securedRouter.get '/api/v2/sales/:id', routers.sales.read
		securedRouter.delete '/api/v2/sales/:id', routers.sales.delete

	if routers.coupons?
		securedRouter.post '/api/v2/coupons', koaBody, routers.coupons.create
		securedRouter.get '/api/v2/coupons', koaBody, routers.coupons.list
		securedRouter.put '/api/v2/coupons/:id', koaBody, routers.coupons.update
		securedRouter.get '/api/v2/coupons/:id', routers.coupons.read
		securedRouter.delete '/api/v2/coupons/:id', routers.coupons.delete

	#
	# if routers.userSettings
	# 	securedRouter.get '/api/user-settings/:username', routers.userSettings.get
	# 	securedRouter.put '/api/user-settings/:username', koaBody, routers.userSettings.update
	#
	# if routers.worktimeStats
	# 	securedRouter.get '/api/stats/worktime/:username', koaBody, routers.worktimeStats.get
	# 	securedRouter.post '/api/stats/worktime/:username', koaBody, routers.worktimeStats.get

	app.use(securedRouter.routes()).use(securedRouter.allowedMethods())


	# catch all client routes
	app.use (next) ->
		yield next

		if not @body and not @url.startsWith '/api'
			yield send @, 'index.html', root: config.staticFileDirectory

	return app
