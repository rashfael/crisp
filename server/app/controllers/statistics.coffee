mongoose = require 'mongoose'
Sale = mongoose.model 'Sale'
log = require('log4js').getLogger('statistics-controller')

module.exports = class StatisticsController

	supplierArticleProfit: (start, end) =>
		map = ->
			for item in this.items
				emit {supplierId: item.supplierId, productId: item.productId}, {amount: item.amount, sum: item.price}
			for coupon in this.coupons when coupon.valuechange > 0 # only add bought coupons to statistic
				emit {coupon: true}, {amount: 1, sum: coupon.price}
			return

		reduce = (key, values) ->
			sum = 0
			amount = 0
			for value in values
				amount += value.amount
				sum += value.sum
			return {amount, sum}

		mapReduce =
			map: map
			reduce: reduce
			query: {date: {$gte: start, $lt: end}}
			verbose: true
		results = yield Sale.mapReduce(mapReduce)
		return results
