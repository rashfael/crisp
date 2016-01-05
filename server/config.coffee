path = require 'path'

module.exports =
	api:
		port: 9000
	staticFileDirectory: path.normalize __dirname + '/../web-client/public'
