View = require 'views/base/view'
{Product} = require 'models/products'

parseCurrency = (string) -> parseFloat string.replace ',','.'

module.exports = class SupplierItemView extends View
	autoRender: true
	className: 'supplier'
	template: require './templates/item'
	events:
		'submit': 'onSubmit'
		'click #details-tab': 'showDetails'
		'click #history-tab': 'showHistory'

	onSubmit: =>

		return false

	showTab: (name) =>
		@$('.tabs li').removeClass 'active'
		@$("##{name}-tab").parent().addClass 'active'

		@$('.tab-content > div').removeClass 'active'
		@$("##{name}").addClass 'active'

	showDetails: ->
		@showTab 'details'

	showHistory: ->
		@showTab 'history'
