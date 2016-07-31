mongoose = require 'mongoose'

Cashier = new mongoose.Schema
	_id: String
	password: String
	name: String
	forename: String


module.exports = mongoose.model 'Cashier', Cashier, 'cashiers'
