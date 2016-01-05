$ = require 'jquery'
Chaplin = require 'chaplin'
mediator = require 'mediator'
LoginView = require 'views/login-view'
User = require 'models/user'

module.exports = class AuthenticationController extends Chaplin.Controller
	initialize: ->
		@_getSession()

	_getSession: =>
		user = JSON.parse localStorage.getItem 'user'
		return @_showLoginPrompt() unless user?
		$.ajax
			url: '/api/authenticate'
			headers:
				Authorization: 'Bearer ' + user.token
			dataType: 'json'
			success: (user) =>
				if user?
					@_loginSuccess user
				else
					@_showLoginPrompt()
			error: () =>
				@_showLoginPrompt()

	_loginSuccess: (user) =>
		mediator.user = new User user
		localStorage.setItem 'user', JSON.stringify user
		@publishEvent '!auth:success'
		return

	_showLoginPrompt: =>
		mediator.user = new User()
		@view = new LoginView
			model: mediator.user
		@listenTo @view, 'login', (password) =>
			@view.dispose()
			# @_loginSuccess(mediator.user)
			data =
				username: mediator.user.get 'username'
				password: password
			$.post '/api/login', data, (user) =>
				@_loginSuccess user

		#@view = new LoginView()
