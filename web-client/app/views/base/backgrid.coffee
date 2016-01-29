moment = require 'moment'

View = require './view'
Backgrid = require 'backgrid'
translations = require 'translations'

module.exports.ChapRow = class ChapRow extends View
	_.extend @::, Backgrid.Row::

	events:
		'click': 'onClick'

	onClick: ->
		@publishEvent 'row:clicked', @model

module.exports.currencyFormatter = _.extend {}, Backgrid.CellFormatter.prototype,
	fromRaw: (rawValue, model) -> rawValue?.toLocaleString 'de-DE', minimumFractionDigits: 2

module.exports.dateFormatter = _.extend {}, Backgrid.CellFormatter.prototype,
	fromRaw: (rawValue, model) -> moment(rawValue).format translations.dateFormat

module.exports.percentFormatter = _.extend {}, Backgrid.CellFormatter.prototype,
	fromRaw: (rawValue, model) -> rawValue * 100 + '%'
