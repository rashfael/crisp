_ = require 'lodash'
moment = require 'moment'
mediator = require 'mediator'

Controller = require 'controllers/base/controller'
HeaderView = require 'views/home/header-view'
HomePageView = require 'views/home/home-page-view'

module.exports = class HomeController extends Controller

	beforeAction: ->
		super
		@reuse 'header', HeaderView, region: 'header'

	index: (params) ->
		
