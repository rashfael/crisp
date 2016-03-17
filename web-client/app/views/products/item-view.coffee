View = require 'views/base/view'
{Product} = require 'models/products'

parseCurrency = (string) -> parseFloat string.replace ',','.'

module.exports = class ProductsItemView extends View
	autoRender: true
	className: 'products'
	template: require './templates/item'
	events:
		'submit': 'onSubmit'
		'click #details-tab': 'showDetails'
		'click #history-tab': 'showHistory'

	onSubmit: =>
		data =
			name: @$('form [name=name]').val()
			productGroupId: @$('form [name=productGroupId]').val()
			supplierId: @$('form [name=supplierId]').val()
			supplierProductId: @$('form [name=supplierProductId]').val()
			printerline1: @$('form [name=printerline1]').val()
			printerline1: @$('form [name=printerline1]').val()
			cost: parseCurrency @$('form [name=cost]').val()
			sale: parseCurrency @$('form [name=sale]').val()
		@trigger 'save', data
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
