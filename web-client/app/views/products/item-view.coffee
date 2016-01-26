View = require 'views/base/view'
{Product} = require 'models/products'

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
			_id: @$('form [name=id]').val()
			name: @$('form [name=name]').val()
			productGroupId: @$('form [name=productGroupId]').val()
			supplierId: @$('form [name=supplierId]').val()
			supplierProductId: @$('form [name=supplierProductId]').val()
			printerline1: @$('form [name=printerline1]').val()
			printerline1: @$('form [name=printerline1]').val()
			cost: @$('form [name=cost]').val()
			sale: @$('form [name=sale]').val()

		model = new Product data
		@trigger 'new', model
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
