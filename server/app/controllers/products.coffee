mongoose = require 'mongoose'
Product = mongoose.model 'Product'
log = require('log4js').getLogger('products-controller')

module.exports = class ProductController
	create: (obj) =>
		yield new Product(obj).save()

	find: (query, projection, options) =>
		yield Product.find(query, projection, options).exec()

	count: (query) =>
		yield Product.count(query).exec()

	findOne: (query, projection, options) =>
		yield Product.findOne(query, projection, options).exec()

	update: (id, update) =>
		yield Product.findByIdAndUpdate(id, update, {new:true}).exec()

	remove: (query) =>
		yield Product.remove query

	generateId: =>
		pad = (n) ->
			('00000' + n).slice -6
		ids = yield Product.find({}, {_id: 1}, {sort: {_id: 1}, lean:true}).exec()
		candidate = 1
		lowerIndex = 0
		while candidate < 999999 and lowerIndex < ids.length # die at max id
			if ids[lowerIndex]._id.length isnt 6 # discard non-barcode ids
				lowerIndex++
				continue
			if ids[lowerIndex]._id isnt pad candidate
				return pad candidate
			lowerIndex++
			candidate++

		@status = 204
		return ids
