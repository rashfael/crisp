View = require 'views/base/view'
mediator = require 'mediator'

# Site view is a top-level view which is bound to body.
module.exports = class LoginView extends View
	container: 'body'
	id: 'site-container'
	containerMethod: 'html'
	autoRender: true
	template: require 'views/templates/login'
	events:
		'submit': 'onSubmit'
		
	onSubmit: =>
		@model.set 'username', @$('[name="username"]').val()
		password = @$('[name="password"]').val()
		@trigger 'login', password
		return false
