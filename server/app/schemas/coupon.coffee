mongoose = require 'mongoose'

CouponItem = new mongoose.Schema
	saleId: Number
	valuechange:
		type: Number
		get: (x) -> x/100 if x?
		set: (x) -> parseInt(x*100)
	date: Date
,
	toObject : {getters: true}
	toJSON : {getters: true}

Coupon = new mongoose.Schema
	_id: Number
	value:
		type: Number
		get: (x) -> x/100 if x?
		set: (x) -> parseInt(x*100)
	items: [CouponItem]
,
	toObject : {getters: true}
	toJSON : {getters: true}

module.exports = mongoose.model 'Coupon', Coupon, 'coupons'
