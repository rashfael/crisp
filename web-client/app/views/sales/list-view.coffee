_ = require 'lodash'

View = require 'views/base/view'
Backgrid = require 'backgrid'
translations = require 'translations'

{ChapRow, currencyFormatter, dateFormatter, percentFormatter} = require 'views/base/backgrid'

class ChapGrid extends View
	_.extend @::, Backgrid.Grid::

	columns: [
		name: '_id'
		label: 'Bonnummer'
	,
		name: 'date'
		label: 'Datum'
		formatter: dateFormatter
	,
		name: 'customerId'
		label: 'Kunde'
	,
		name: 'price'
		label: 'Betrag'
		formatter: currencyFormatter
		cell: 'number'
	,
		name: 'discount'
		label: 'Rabatt'
		formatter: percentFormatter
		cell: 'number'
	]

	for column in @::columns
		column.editable = false
		column.cell = 'string' if not column.cell?

module.exports = class SalesListView extends View
	autoRender: true
	className: 'sales'
	template: require './templates/list'
	regions:
		pagination: '#pagination'
		grid: '#sales-list'

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
		grid.container = @$ '#sales-list'
		grid.render()

	onSearch: (event) =>
		event.preventDefault()
		@publishEvent '!search', @$('input').val()
