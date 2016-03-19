mediator = require 'mediator'
$ = require 'jquery'
Model = require 'models/base/model'
Controller = require 'controllers/base/controller'
{StatisticsView, CoreStatisticsView} = require 'views/statistics/view'

module.exports = class StatisticsController extends Controller

	index: (params) ->
		@view = new StatisticsView
			region: 'main'

		model = new Model()

		@view.subview 'pagination', new CoreStatisticsView
			model: model
			region: 'statistics'
		# $.getJSON "/api/v2/suppliers/#{params.id}/statistics", (data) -> cb null, data
