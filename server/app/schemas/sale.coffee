mongoose = require 'mongoose'

SaleItem = new mongoose.Schema
	productId: String
	price:
		type: Number
		get: (x) -> x/100 if x?
		set: (x) -> parseInt(x*100)
	discount:
		type: Number
		get: (x) -> x/10000 if x?
		set: (x) -> parseInt(x*10000)
	amount: Number
	supplierId: Number
,
	toObject : {getters: true}
	toJSON : {getters: true}

CouponItem = new mongoose.Schema
	couponId: Number
	valuechange:
		type: Number
		get: (x) -> x/100 if x?
		set: (x) -> parseInt(x*100)
,
	toObject : {getters: true}
	toJSON : {getters: true}

ReturnItem = new mongoose.Schema
	saleId: Number
	productId: Number
	amount: Number
	price:
		type: Number
		get: (x) -> x/100 if x?
		set: (x) -> parseInt(x*100)
,
	toObject : {getters: true}
	toJSON : {getters: true}

Sale = new mongoose.Schema
	_id: Number
	customerId: Number
	paymentMethodId: Number
	cashier: String
	price:
		type: Number
		get: (x) -> x/100 if x?
		set: (x) -> parseInt(x*100)
	discount:
		type: Number
		get: (x) -> x/10000 if x?
		set: (x) -> parseInt(x*10000)
	date: {type: Date, default: Date.now}
	shop: String
	items: [SaleItem]
	coupons: [CouponItem]
	returns: [ReturnItem]
,
	toObject : {getters: true}
	toJSON : {getters: true}

# Sale.methods.objectify = ->
# 	obj = @toObject({getters: true})
# 	if obj.items.length > 0
# 		for i in [0..obj.items.length-1]
# 			obj.items[i] = obj.items[i].toObject({getters: true})
# 			delete obj.items[i].id
# 	if obj.returns.length > 0
# 		for i in [0..obj.returns.length-1]
# 			obj.returns[i] = obj.returns[i].toObject({getters: true})
# 			delete obj.returns[i].id
# 	if obj.coupons.length > 0
# 		for i in [0..obj.coupons.length-1]
# 			obj.coupons[i] = obj.coupons[i].toObject({getters: true})
# 			delete obj.coupons[i].id
# 	return obj

module.exports = mongoose.model 'Sale', Sale, 'sales'
