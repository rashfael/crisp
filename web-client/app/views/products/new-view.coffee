View = require 'views/base/view'
{Product} = require 'models/products'

module.exports = class ProductsListView extends View
	autoRender: true
	className: 'products'
	template: require './templates/item-form'

	events:
		'submit': 'onSubmit'
		'click #generate': 'onGenerate'

	onSubmit: =>
		data =
			_id: @$('form [name=_id]').val()
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

	onGenerate: (event) =>
		@trigger 'generateId'

	setId: (id) =>
		@$('form [name=_id]').val id
