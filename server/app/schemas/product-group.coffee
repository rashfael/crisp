mongoose = require 'mongoose'

ProductGroup = new mongoose.Schema
	_id: Number
	name: String

module.exports = mongoose.model 'ProductGroup', ProductGroup, 'productGroups'
