mongoose = require 'mongoose'
Customer = mongoose.model 'Customer'
log = require('log4js').getLogger('customers-controller')

module.exports = class CustomersController
	create: (obj) =>
		yield new Customer(obj).save()

	find: (query, projection, options) =>
		yield Customer.find(query, projection, options).exec()

	count: (query) =>
		yield Customer.count(query).exec()

	findOne: (query, projection, options) =>
		yield Customer.findOne(query, projection, options).exec()

	update: (id, update) =>
		yield Customer.findByIdAndUpdate(id, update, {new:true}).exec()

	remove: (query) =>
		yield Customer.remove query
