mongoose = require 'mongoose'
Supplier = mongoose.model 'Supplier'
log = require('log4js').getLogger('suppliers-controller')

module.exports = class ProductController
	create: (obj) =>
		yield new Supplier(obj).save()

	find: (query, projection, options) =>
		yield Supplier.find(query, projection, options).exec()

	count: (query) =>
		yield Supplier.count(query).exec()

	findOne: (query, projection, options) =>
		yield Supplier.findOne(query, projection, options).exec()

	update: (id, update) =>
		yield Supplier.findByIdAndUpdate(id, update, {new:true}).exec()

	remove: (query) =>
		yield Supplier.remove query
