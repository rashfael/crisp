async = require 'async'
$ = require 'jquery'
mediator = require 'mediator'
Controller = require 'controllers/base/controller'

{Coupon, Coupons} = require 'models/coupons'

CouponsListView = require 'views/coupons/list-view'
CouponItemView = require 'views/coupons/item-view'


PaginationView = require 'views/pagination-view'

module.exports = class CouponsController extends Controller

	index: (params) ->

		coupons = new Coupons()
		coupons.fetch reset: true
		@view = new CouponsListView
			region: 'main'
			collection: coupons

		@view.subview 'pagination', new PaginationView
			model: coupons.metadata
			region: 'pagination'

		@subscribeEvent 'pagination:page', (page) =>
			console.log 'load', page
			coupons.fetch
				reset: true
				data:
					skip: page * 100

		@subscribeEvent '!search', (query) =>
			console.log query
			coupons.fetch
				reset: true
				data:
					search: query

		@subscribeEvent 'row:clicked', (coupon) =>
			@redirectTo {controller: CouponsController, action: 'item', params: {id: coupon.get '_id'}}

	item: (params) =>
		coupon = new Coupon
			_id: params.id
		coupon.fetch success: =>
			@view = new CouponItemView
				region: 'main'
				model: coupon
