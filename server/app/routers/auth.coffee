log4js = require 'log4js'
log = log4js.getLogger 'crisp-auth'

auth = require('../controllers').auth

module.exports.login = (next) ->
	unless @request.body.username? and @request.body.password?
		@status = 400
		log.warn 'Invalid login request'
		return
	token = yield auth.authenticate @request.body
	yield from next
	@body =
		username: @request.body.username
		token: token

module.exports.authMiddleware = (next) ->
	if @header?.authorization?
		[key, token] = @header.authorization.split ' '
	if key is 'Bearer' and token?
		@request.token = token
	else
		@status = 401
		return

	user = yield auth.authorize token
	if not user?
		@status = 403
		return
	@request.user = user
	yield next

module.exports.authenticate = (next) ->
	yield next
	user =
		username: @request.user.username
		token: @request.token
	@body = JSON.stringify user
