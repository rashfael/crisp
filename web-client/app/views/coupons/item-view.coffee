_ = require 'lodash'

View = require 'views/base/view'
translations = require 'translations'

module.exports = class CouponItemView extends View
	autoRender: true
	className: 'coupon'
	template: require './templates/item'
	events:
		'click #details-tab': 'showDetails'
		'click #items-tab': 'showItems'

	showTab: (name) =>
		@$('.tabs li').removeClass 'active'
		@$("##{name}-tab").parent().addClass 'active'

		@$('.tab-content > div').removeClass 'active'
		@$("##{name}").addClass 'active'

	showDetails: ->
		@showTab 'details'

	showItems: ->
		@showTab 'items'
