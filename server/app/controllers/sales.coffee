mongoose = require 'mongoose'
Sale = mongoose.model 'Sale'
log = require('log4js').getLogger('sales-controller')

module.exports = class SalesController
	create: (obj) =>
		yield new Sale(obj).save()

	find: (query, projection, options) =>
		yield Sale.find(query, projection, options).exec()

	count: (query) =>
		yield Sale.count(query).exec()

	findOne: (query, projection, options) =>
		yield Sale.findOne(query, projection, options).exec()

	update: (id, update) =>
		yield Sale.findByIdAndUpdate(id, update, {new:true}).exec()

	remove: (query) =>
		yield Sale.remove query

	supplierStatistics: (supplierId) =>
		map = ->
			for item in this.items
				if item.supplierId is supplierId
					emit {year: this.date.getFullYear(),month: this.date.getMonth()}, {amount: item.amount, sum: item.price}

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
			scope: {supplierId: supplierId}
			query: {'items.supplierId': supplierId}
			verbose: true

		results = yield Sale.mapReduce(mapReduce)
		stats = {}
		total = {amount:0, sum:0}
		for result in results
			date = new Date result._id.year, result._id.month, 1, 1
			stats[date] = result.value
			total.amount += result.value.amount
			total.sum += result.value.sum
		ret =
			stats: stats
			total: total
		return ret
