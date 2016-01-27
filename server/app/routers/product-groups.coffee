produtGroupsController = require('../controllers').productGroups

log = require('log4js').getLogger('product-groups-router')

module.exports.create = (next) ->
	saved = yield produtGroupsController.create @request.body
	@status = 201
	@body = saved
	yield next

module.exports.list = (next) ->
	query = {}

	options =
		skip: parseInt(@query?.skip) or 0
		# limit:

	[list, count] = yield [
		produtGroupsController.find query, @request.body?.projection, options
		produtGroupsController.count query
	]
	@body =
		items: list
		metadata:
			totalCount: count
			limit: options.limit
			skip: options.skip

	yield next

module.exports.read = (next) ->
	item = yield produtGroupsController.findOne _id: @params.id
	@body = item
	yield next

module.exports.update = (next) ->
	item = yield produtGroupsController.update @params.id, @request.body
	@body = item
	yield next

module.exports.delete = (next) ->
	result = yield produtGroupsController.remove _id: @params.id
	if result.result.n is 0
		@status = 404
	else
		@status = 204
	yield next
