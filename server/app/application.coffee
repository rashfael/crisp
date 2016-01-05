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

	publicRouter.post '/api/login', koaBody, routers.auth.login


	app.use(publicRouter.routes()).use(publicRouter.allowedMethods())

	securedRouter = Router()
	securedRouter.use routers.auth.authMiddleware
	securedRouter.get '/api/authenticate', routers.auth.authenticate

	# if routers.activity?
	# 	securedRouter.post '/api/activities', koaBody, routers.activity.create
	# 	securedRouter.get '/api/activities', koaBody, routers.activity.list
	# 	securedRouter.put '/api/activities/:id', koaBody, routers.activity.update
	# 	securedRouter.get '/api/activities/:id', routers.activity.read
	# 	securedRouter.delete '/api/activities/:id', routers.activity.delete
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
