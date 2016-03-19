$ = require 'jquery'
View = require 'views/base/view'

module.exports = class HeaderView extends View
	autoRender: true
	className: 'nav'
	tagName: 'nav'
	template: require './templates/header'
	events:
		'click .toggle-cost': 'toggleCost'

	toggleCost: (event) =>
		@publishEvent 'toggleCost'

	displayError: (error) =>
		text = error.toString()
		if error.conflicts?
			text += ' '
			text += error.conflicts.map((i) -> new Activity(i).toString()).join(', ')

		@$('#error-bubble').text text
		@$('#error-bubble').show()
