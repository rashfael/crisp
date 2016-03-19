_ = require 'lodash'

View = require 'views/base/view'
Backgrid = require 'backgrid'
translations = require 'translations'

{ChapRow, currencyFormatter, dateFormatter, percentFormatter} = require 'views/base/backgrid'

class ChapGrid extends View
	_.extend @::, Backgrid.Grid::

	columns: [
		name: '_id'
		label: 'Gutscheinnummer'
	,
		name: 'value'
		label: 'Aktueller Wert'
		formatter: currencyFormatter
		cell: 'number'

	]

	for column in @::columns
		column.editable = false
		column.cell = 'string' if not column.cell?

module.exports = class CouponsListView extends View
	autoRender: true
	className: 'coupons'
	template: require './templates/list'
	regions:
		pagination: '#pagination'
		grid: '#coupons-list'

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
		grid.container = @$ '#coupons-list'
		grid.render()

	onSearch: (event) =>
		event.preventDefault()
		@publishEvent '!search', @$('input').val()
