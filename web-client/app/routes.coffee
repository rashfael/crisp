HomeController = require('controllers/home-controller')
HelpController = require('controllers/help-controller')

# Application routes.
module.exports = (match) ->
	match '', {controller: HomeController, action: 'index'}
	match 'help', {controller: HelpController, action: 'index'}
