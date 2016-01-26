_ = require 'lodash'

View = require 'views/base/view'
Backgrid = require 'backgrid'
translations = require 'translations'

class Chaprow extends View
	_.extend @::, Backgrid.Row::

	events:
		'click': 'onClick'

	onClick: ->
		@publishEvent 'row:clicked', @model

# class SupplierCell extend Backgrid.Cell
# 	className: 'supplier-cell'
# 	formatter: SupplierFormatter

class Chapgrid extends View
	_.extend @::, Backgrid.Grid::

	columns: [
		name: '_id'
		label: 'Artikelnummer'
	,
		name: 'name'
		label: 'Name'
	,
		name: 'productGroupId'
		label: 'Gruppe'
	,
		name: 'supplierId'
		label: 'Lieferant'
		formatter: _.extend {}, Backgrid.CellFormatter.prototype,
			fromRaw: (rawValue, model) -> translations.suppliersMap[rawValue].name
	,
		name: 'supplierProductId'
		label: 'LiefNr'
	,
		name: 'cost'
		label: 'EK'
	,
		name: 'sale'
		label: 'VK'
	,
		name: 'stock'
		label: 'Lager'
	]

	for column in @::columns
		column.editable = false
		column.cell = 'string' if not column.cell?

module.exports = class ProductsListView extends View
	autoRender: true
	className: 'products'
	template: require './templates/list'
	regions:
		pagination: '#pagination'
		grid: '#products-list'

	events:
		'submit form': 'onSearch'

	initialize: (options) =>
		super options
		@subview 'grid', new Chapgrid
			row: Chaprow
			collection: @collection

	render: =>
		super
		grid = @subview 'grid'
		grid.container = @$ '#products-list'
		grid.render()

	onSearch: (event) =>
		event.preventDefault()
		@publishEvent '!search', @$('input').val()
