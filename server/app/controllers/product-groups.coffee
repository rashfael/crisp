mongoose = require 'mongoose'
ProductGroup = mongoose.model 'ProductGroup'
log = require('log4js').getLogger('product-group-controller')

module.exports = class ProductGroupsController
	create: (obj) =>
		yield new ProductGroup(obj).save()

	find: (query, projection, options) =>
		yield ProductGroup.find(query, projection, options).exec()

	count: (query) =>
		yield ProductGroup.count(query).exec()

	findOne: (query, projection, options) =>
		yield ProductGroup.findOne(query, projection, options).exec()

	update: (id, update) =>
		yield ProductGroup.findByIdAndUpdate(id, update, {new:true}).exec()

	remove: (query) =>
		yield ProductGroup.remove query
