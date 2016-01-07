mongoose = require 'mongoose'
Product = mongoose.model 'Product'
log = require('log4js').getLogger('products-controller')

module.exports = class ProductController
	create: (obj) =>
		yield new Product(obj).save()

	find: (query, projection, options) =>
		yield Product.find(query, projection, options).exec()

	findOne: (query, projection, options) =>
		yield Product.findOne(query, projection, options).exec()

	update: (id, update) =>
		yield Product.findByIdAndUpdate(id, update, {new:true}).exec()

	remove: (query) =>
		yield Product.remove query
