customersController = require('../controllers').customers
salesController = require('../controllers').sales

log = require('log4js').getLogger('customers-router')

module.exports.create = (next) ->
	saved = yield customersController.create @request.body
	@status = 201
	@body = saved
	yield next

module.exports.list = (next) ->
	query = {}

	options =
		skip: parseInt(@query?.skip) or 0
		limit: 100

	[list, count] = yield [
		customersController.find query, @request.body?.projection, options
		customersController.count query
	]
	@body =
		items: list
		metadata:
			totalCount: count
			limit: options.limit
			skip: options.skip

	yield next

module.exports.read = (next) ->
	item = yield customersController.findOne _id: @params.id
	@body = item
	yield next

module.exports.history = (next) ->
	query =
		customerId: parseInt @params.id
	options =
		sort: {date: -1}
	# TODO redo with aggregation
	sales = yield salesController.find query, {_id: 1, date: 1, price: 1, discount: 1}, options

	@body = sales
	yield next

module.exports.update = (next) ->
	item = yield customersController.update @params.id, @request.body
	@body = item
	yield next

module.exports.delete = (next) ->
	result = yield customersController.remove _id: @params.id
	if result.result.n is 0
		@status = 404
	else
		@status = 204
	yield next
