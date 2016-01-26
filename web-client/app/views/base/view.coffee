moment = require 'moment'
Chaplin = require 'chaplin'
Backbone = require 'backbone'

translations = require 'translations'

require 'lib/view-helper' # Just load the view helpers, no return value


preventWrapper = (func) ->
	return (event) ->
		event.preventDefault()
		func.apply @, arguments
		return false

module.exports = class View extends Chaplin.View
	# Auto-save `template` option passed to any view as `@template`.
	optionNames: Chaplin.View::optionNames.concat ['template']

	# Precompiled templates function initializer.
	getTemplateFunction: ->
		@template

	getTemplateData: ->
		data = super()
		data.moment = moment
		data.config = require 'config'
		data.formats =
			timeFormat: 'H:mm'
		data.translations = translations
		return data

	_delegateEvents: (events) ->
		if Backbone.View::delegateEvents.length is 2
			return Backbone.View::delegateEvents.call this, events, true
		for key, value of events
			handler = if typeof value is 'function' then value else this[value]
			throw new Error "Method '#{value}' does not exist" unless handler
			match = key.match /^(\S+)\s*(.*)$/
			eventName = "#{match[1]}.delegateEvents#{@cid}"
			selector = match[2]
			bound = handler.bind @
			@$el.on eventName, (selector or null), preventWrapper bound
		return
