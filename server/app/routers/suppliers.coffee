suppliersController = require('../controllers').suppliers
salesController = require('../controllers').sales

log = require('log4js').getLogger('suppliers-router')

module.exports.create = (next) ->
	saved = yield suppliersController.create @request.body
	@status = 201
	@body = saved
	yield next

module.exports.list = (next) ->
	query = {}

	options =
		limit: parseInt(@query?.limit) or 100
		skip: parseInt(@query?.skip) or 0

	[list, count] = yield [
		suppliersController.find query, @request.body?.projection, options
		suppliersController.count query
	]
	@body =
		items: list
		metadata:
			totalCount: count
			limit: options.limit
			skip: options.skip

	yield next

module.exports.read = (next) ->
	item = yield suppliersController.findOne _id: @params.id
	@body = item
	yield next

module.exports.statistics = (next) ->
	stats = yield salesController.supplierStatistics parseInt @params.id
	@body = stats
	yield next

module.exports.update = (next) ->
	item = yield suppliersController.update @params.id, @request.body
	@body = item
	yield next

module.exports.delete = (next) ->
	result = yield suppliersController.remove _id: @params.id
	if result.result.n is 0
		@status = 404
	else
		@status = 204
	yield next
