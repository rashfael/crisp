mongoose = require 'mongoose'


Supplier = new mongoose.Schema
	_id: Number
	name: String
	name2: String
	street: String
	zip: String
	place: String
	tel: String
	tel2: String
	fax: String
	email: String
	notes: String

module.exports = mongoose.model 'Supplier', Supplier, 'suppliers'
