productsController = require('../controllers').products
log = require('log4js').getLogger('products-router')

module.exports.create = (next) ->
	saved = yield productsController.create @request.body
	@status = 201
	@body = saved
	yield next

module.exports.list = (next) ->
	query = {}
	# if @query['min-date']? and @query['max-date']?
	# 	query.begin =
	# 			$lte: new Date @query['max-date']
	# 	query.$or = [
	# 			end: $exists: false
	# 		,
	# 			end: $gte: new Date @query['min-date']
	# 		]
	# if @query.user?
	# 	query.user = @query.user

	list = yield productsController.find query, @request.body?.projection, @request.body?.options
	@body = list
	yield next

module.exports.read = (next) ->
	item = yield productsController.findOne _id: @params.id
	@body = item
	yield next

module.exports.update = (next) ->
	item = yield productsController.update @params.id, @request.body
	@body = item
	yield next

module.exports.delete = (next) ->
	result = yield productsController.remove _id: @params.id
	if result.result.n is 0
		@status = 404
	else
		@status = 204
	yield next
