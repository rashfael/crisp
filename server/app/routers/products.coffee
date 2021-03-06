_ = require 'lodash'

productsController = require('../controllers').products
salesController = require('../controllers').sales

log = require('log4js').getLogger('products-router')

module.exports.create = (next) ->
	saved = yield productsController.create @request.body
	@status = 201
	@body = saved
	yield next

module.exports.list = (next) ->
	query = {}

	if @query.search?
		query =
			$or: [
				_id:
					$regex: '^' + @query.search
					$options: 'i'
			,
				name:
					$regex: @query.search
					$options: 'i'
			,
				supplierProductId:
					$regex: @query.search
					$options: 'i'
			]
	options =
		limit: parseInt(@query?.limit) or 100
		skip: parseInt(@query?.skip) or 0
		sort: '_id'

	[list, count] = yield [
		productsController.find query, @request.body?.projection, options
		productsController.count query
	]
	@body =
		items: _.map list, (obj) -> obj.toObject getters:true
		metadata:
			totalCount: count
			limit: options.limit
			skip: options.skip

	yield next

module.exports.read = (next) ->
	item = yield productsController.findOne _id: @params.id
	@body = item
	yield next

module.exports.history = (next) ->
	query =
		'items.productId': @params.id
	options =
		sort: {date: -1}
	# TODO redo with aggregation
	sales = yield salesController.find query, {_id: 1, date: 1, customerId: 1}, options

	saleItems = []
	for sale in sales
		saleItems.push
			saleId: sale._id
			date: sale.date
			customerId: sale.customerId

	@body = saleItems
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

module.exports.generateId = (next) ->
	result = yield productsController.generateId()
	@body = JSON.stringify result

module.exports.arrival = (next) ->
	result = yield productsController.addArrival @params.id, @request.body.amount, @request.body.shop
	@body = result
	yield next
