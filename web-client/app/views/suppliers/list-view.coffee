_ = require 'lodash'

View = require 'views/base/view'
Backgrid = require 'backgrid'
translations = require 'translations'

{ChapRow} = require 'views/base/backgrid'

class ChapGrid extends View
	_.extend @::, Backgrid.Grid::

	columns: [
		name: '_id'
		label: 'Lieferantennummer'
	,
		name: 'name'
		label: 'Name'
	]

	for column in @::columns
		column.editable = false
		column.cell = 'string' if not column.cell?

module.exports = class SuppliersListView extends View
	autoRender: true
	className: 'suppliers'
	template: require './templates/list'
	regions:
		pagination: '#pagination'
		grid: '#suppliers-list'

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
		grid.container = @$ '#suppliers-list'
		grid.render()

	onSearch: (event) =>
		event.preventDefault()
		@publishEvent '!search', @$('input').val()
