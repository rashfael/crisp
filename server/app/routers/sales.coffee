_ = require 'lodash'

salesController = require('../controllers').sales

log = require('log4js').getLogger('sales-router')

module.exports.create = (next) ->
	saved = yield salesController.create @request.body
	@status = 201
	@body = saved
	yield next

module.exports.list = (next) ->
	query = {}
	if @query.search?
		query =
			_id: parseInt @query.search
	options =
		limit: 100
		skip: parseInt(@query?.skip) or 0
		sort:
			date: -1

	[list, count] = yield [
		salesController.find query, @request.body?.projection, options
		salesController.count query
	]
	@body =
		items: _.map list, (obj) -> obj.toObject getters:true
		metadata:
			totalCount: count
			limit: options.limit
			skip: options.skip

	yield next

module.exports.read = (next) ->
	item = yield salesController.findOne _id: @params.id
	@body = item
	yield next


module.exports.update = (next) ->
	item = yield salesController.update @params.id, @request.body
	@body = item
	yield next

module.exports.delete = (next) ->
	result = yield salesController.remove _id: @params.id
	if result.result.n is 0
		@status = 404
	else
		@status = 204
	yield next
