Model = require 'models/base/model'
Collection = require 'models/base/collection'

module.exports.Coupon = class Coupon extends Model
	idAttribute: '_id'
	urlRoot: '/api/v2/coupons'
	new: false

	isNew: => @new or not @has @idAttribute

module.exports.Coupons = class Coupons extends Collection
	model: Coupon
	url: '/api/v2/coupons'

	constructor: ->
		@metadata = new Model()
		super

	parse: (response) =>
		@metadata.set response.metadata
		return response.items
