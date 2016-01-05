mediator = require 'mediator'

Controller = require 'controllers/base/controller'
HelpView = require 'views/help-view'


module.exports = class HomeController extends Controller

	index: (params) ->
		@view = new HelpView
			region: 'main'
