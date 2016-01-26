$ = require 'jquery'
Chaplin = require 'chaplin'
mediator = require 'mediator'
translations = require 'translations'
AuthenticationController = require 'controllers/authentication-controller'

# Install polyfill
String.prototype.startsWith ?= (searchString, position) ->
	position = position or 0
	return this.indexOf(searchString, position) is position

module.exports = class Application extends Chaplin.Application
	serverUrl: location.protocol + "//" + location.host
	initialize: (@options) =>
		mediator.subscribe '!auth:success', @initNormalApplication
		new AuthenticationController()

	initNormalApplication: =>
		$('body').empty()
		Application.__super__.initialize.call @, @options

	start: ->
		translations.fetch =>
			super
