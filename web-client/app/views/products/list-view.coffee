_ = require 'lodash'

View = require 'views/base/view'
Backgrid = require 'backgrid'
translations = require 'translations'

{ChapRow, currencyFormatter} = require 'views/base/backgrid'

class ChapGrid extends View
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
		formatter: _.extend {}, Backgrid.CellFormatter.prototype,
			fromRaw: (rawValue, model) -> translations.productGroupsMap[rawValue]?.name
	,
		name: 'supplierId'
		label: 'Lieferant'
		formatter: _.extend {}, Backgrid.CellFormatter.prototype,
			fromRaw: (rawValue, model) -> translations.suppliersMap[rawValue]?.name
	,
		name: 'supplierProductId'
		label: 'LiefNr'
	,
		name: 'cost'
		label: 'EK'
		formatter: currencyFormatter
		cell: 'number'
		renderable: false
	,
		name: 'sale'
		label: 'VK'
		formatter: currencyFormatter
		cell: 'number'
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
		@subview 'grid', new ChapGrid
			row: ChapRow
			collection: @collection

	render: =>
		super
		grid = @subview 'grid'
		grid.container = @$ '#products-list'
		grid.render()
		@subscribeEvent 'toggleCost', =>
			grid.columns.find({name:'cost'}).set 'renderable', true

	onSearch: (event) =>
		event.preventDefault()
		@publishEvent '!search', @$('input').val()
