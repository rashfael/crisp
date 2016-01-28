_ = require 'lodash'

View = require 'views/base/view'
Backgrid = require 'backgrid'
translations = require 'translations'

{ChapRow} = require 'views/base/backgrid'

class ChapGrid extends View
	_.extend @::, Backgrid.Grid::

	columns: [
		name: '_id'
		label: 'Kundennummer'
	,
		name: 'name'
		label: 'Name'
	,
		name: 'forename'
		label: 'Vorname'
	]

	for column in @::columns
		column.editable = false
		column.cell = 'string' if not column.cell?

module.exports = class CustomersListView extends View
	autoRender: true
	className: 'customers'
	template: require './templates/list'
	regions:
		pagination: '#pagination'
		grid: '#customers-list'

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
		grid.container = @$ '#customers-list'
		grid.render()

	onSearch: (event) =>
		event.preventDefault()
		@publishEvent '!search', @$('input').val()
