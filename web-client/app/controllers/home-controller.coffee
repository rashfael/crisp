mediator = require 'mediator'

Controller = require 'controllers/base/controller'

module.exports = class HomeController extends Controller

	beforeAction: ->
		super

	index: (params) ->
