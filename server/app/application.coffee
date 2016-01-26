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

	if routers.products?
		securedRouter.post '/api/v2/products', koaBody, routers.products.create
		securedRouter.get '/api/v2/products', koaBody, routers.products.list
		securedRouter.put '/api/v2/products/:id', koaBody, routers.products.update
		securedRouter.get '/api/v2/products/generate-id', koaBody, routers.products.generateId
		securedRouter.get '/api/v2/products/:id', routers.products.read
		securedRouter.get '/api/v2/products/:id/history', routers.products.history
		securedRouter.delete '/api/v2/products/:id', routers.products.delete

		if routers.suppliers?
			securedRouter.post '/api/v2/suppliers', koaBody, routers.suppliers.create
			securedRouter.get '/api/v2/suppliers', koaBody, routers.suppliers.list
			securedRouter.put '/api/v2/suppliers/:id', koaBody, routers.suppliers.update
			securedRouter.get '/api/v2/suppliers/:id', routers.suppliers.read
			securedRouter.delete '/api/v2/suppliers/:id', routers.suppliers.delete

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
