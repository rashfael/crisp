mongoose = require 'mongoose'

# Inventory = new Schema {
# 	amount: Number
# 	shop: String
# 	date:
# 		type: Date
# 		default: Date.now
# }

Arrival = new mongoose.Schema
	amount: Number
	shop: String
	date:
		type:Date
		default: Date.now

Transfer = new mongoose.Schema
	amount: Number
	from: String
	to: String
	date:
		type: Date
		default: Date.now

Product = new mongoose.Schema
	_id: String
	name: String
	productGroupId: Number
	supplierId:
		type: Number
		default: 79
	supplierProductId: String
	printerline1: String
	printerline2: String
	cost:
		type: Number
		get: (x) -> x/100 if x?
		set: (x) -> Math.round(x*100)
	sale:
		type: Number
		get: (x) -> x/100 if x?
		set: (x) -> Math.round(x*100)
	stock:
		type: Number
		default: 0
	arrivals: [Arrival]
	transfers: [Transfer]
	# inventory: {}
,
	toObject : {getters: true}
	toJSON : {getters: true}

module.exports = mongoose.model 'Product', Product, 'products'
