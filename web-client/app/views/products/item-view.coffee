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
