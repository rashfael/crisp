mongoose = require 'mongoose'
Sale = mongoose.model 'Sale'
log = require('log4js').getLogger('statistics-controller')

module.exports = class StatisticsController

	supplierArticleProfit: (start, end) =>
		map = ->
			for item in this.items
				emit {supplierId: item.supplierId, productId: item.productId}, {amount: item.amount, sum: item.price}

		reduce = (key, values) ->
			sum = 0
			amount = 0
			for value in values
				amount += value.amount
				sum += value.sum
			return {amount: amount, sum: sum}

		mapReduce =
			map: map
			reduce: reduce
			query: {date: {$gte: start, $lt: end}}
			verbose: true
		console.log mapReduce
		results = yield Sale.mapReduce(mapReduce)
		# stats = {}
		# total = {amount:0, sum:0}
		# for result in results
		# 	date = new Date result._id.year, result._id.month, 1, 1
		# 	stats[date] = result.value
		# 	total.amount += result.value.amount
		# 	total.sum += result.value.sum
		# ret =
		# 	stats: stats
		# 	total: total
		return results
