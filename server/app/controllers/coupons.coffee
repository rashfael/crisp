mongoose = require 'mongoose'
Coupon = mongoose.model 'Coupon'
log = require('log4js').getLogger('sales-controller')

module.exports = class CouponController
	create: (obj) =>
		yield new Coupon(obj).save()

	find: (query, projection, options) =>
		yield Coupon.find(query, projection, options).exec()

	count: (query) =>
		yield Coupon.count(query).exec()

	findOne: (query, projection, options) =>
		yield Coupon.findOne(query, projection, options).exec()

	update: (id, update) =>
		yield Coupon.findByIdAndUpdate(id, update, {new:true}).exec()

	remove: (query) =>
		yield Coupon.remove query
