path = require 'path'

module.exports =
	api:
		port: 8574
	staticFileDirectory: path.normalize __dirname + '/../web-client/dist'
	db: 'mongodb://localhost/crisp-test'
