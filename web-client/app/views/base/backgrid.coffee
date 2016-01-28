View = require './view'
Backgrid = require 'backgrid'

module.exports.ChapRow = class ChapRow extends View
	_.extend @::, Backgrid.Row::

	events:
		'click': 'onClick'

	onClick: ->
		@publishEvent 'row:clicked', @model

module.exports.currencyFormatter = _.extend {}, Backgrid.CellFormatter.prototype,
	fromRaw: (rawValue, model) -> rawValue?.toLocaleString 'de-DE', minimumFractionDigits: 2
