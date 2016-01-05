View = require 'views/base/view'

module.exports = class HelpView extends View
	id: 'help'
	template: require './templates/help'
	autoRender: true
