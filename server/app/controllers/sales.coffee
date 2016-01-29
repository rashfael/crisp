mongoose = require 'mongoose'
Sale = mongoose.model 'Sale'
log = require('log4js').getLogger('sales-controller')

module.exports = class ProductController
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
