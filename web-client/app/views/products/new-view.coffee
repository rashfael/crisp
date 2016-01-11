View = require 'views/base/view'
{Product} = require 'models/products'

module.exports = class ProductsListView extends View
	autoRender: true
	className: 'products'
	template: require './templates/item-form'

	events:
		'submit': 'onSubmit'

	onSubmit: =>
		data =
			_id: @$('form [name=id]').val()
			name: @$('form [name=name]').val()
		model = new Product data
		@trigger 'new', model
		return false
