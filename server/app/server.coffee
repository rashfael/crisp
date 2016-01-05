log4js = require 'log4js'
log = log4js.getLogger 'crisp'

path = require 'path'
fs = require 'fs'

config = require '../config'

mongoose = require 'mongoose'

mongoose.connect 'mongodb://localhost/creatime'
mongoCon = mongoose.connection
mongoCon.once 'open', ->
	log.info 'Connected to database'


require './schemas/coupon'
require './schemas/customer'
# require './schemas/inventory'
require './schemas/product'
require './schemas/product-group'
require './schemas/sale'
require './schemas/supplier'

app = require('./application')()

app.use require('koa-static')(config.staticFileDirectory)

app.on 'error', (err) ->
	log.error err

app.listen config.api.port, ->
	log.info 'Crisp server listening on port ' + config.api.port
