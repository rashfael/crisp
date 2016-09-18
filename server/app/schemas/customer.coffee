mongoose = require 'mongoose'

Customer = new mongoose.Schema
	_id: Number
	name: String
	forename: String
	title: String
	street: String
	zip: String
	place: String
	tel: String
	email: String
	birthday: Date
	customerSince: {type: Date, default: Date.now}
	notes: String

module.exports = mongoose.model 'Customer', Customer, 'customers'
