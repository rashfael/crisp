_ = require 'lodash'
moment = require 'moment'
View = require 'views/base/view'
Backgrid = require 'backgrid'
translations = require 'translations'

{ChapRow} = require 'views/base/backgrid'

daterangepicker = require 'bootstrap-daterangepicker'

module.exports.StatisticsView = class StatisticsView extends View
	autoRender: true
	className: 'statistics'
	template: require './templates/list'
	regions:
		statistics: '#statistics'

	# events:
	# 	'submit form': 'onSearch'
	#
	# initialize: (options) =>
	# 	super options
	# 	@subview 'grid', new ChapGrid
	# 		row: ChapRow
	# 		collection: @collection
	#
	render: =>
		super
		@$('#daterangepicker').daterangepicker
			locale:
				format: 'DD.MM.YYYY'
			showDropdowns: true
			autoApply: true
			ranges:
				'Heute': [moment(), moment()]
				'Gestern': [moment().subtract(1, 'days'), moment().subtract(1, 'days')]
				'Letzte 7 Tage': [moment().subtract(6, 'days'), moment()]
				'Letzte 30 Tage': [moment().subtract(29, 'days'), moment()]
				'Dieser Monat': [moment().startOf('month'), moment().endOf('month')]
				'Letzter Monat': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]

		, (start, end) =>
			@trigger 'range', start, end

module.exports.CoreStatisticsView = class CoreStatisticsView extends View
	template: require './templates/core'
	listen:
		'change': 'render'


	# grid = @subview 'grid'
	# grid.container = @$ '#suppliers-list'
	# grid.render()
	#
	# onSearch: (event) =>
	# 	event.preventDefault()
	# 	@publishEvent '!search', @$('input').val()
