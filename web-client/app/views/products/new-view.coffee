View = require 'views/base/view'
{Product} = require 'models/products'

parseCurrency = (string) -> parseFloat string.replace ',','.'

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
			cost: parseCurrency @$('form [name=cost]').val()
			sale: parseCurrency @$('form [name=sale]').val()
		@trigger 'new', data
		return false

	onGenerate: (event) =>
		@trigger 'generateId'

	setId: (id) =>
		@$('form [name=_id]').val id
