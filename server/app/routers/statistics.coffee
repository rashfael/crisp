_ = require 'lodash'

statisticsController = require('../controllers').statistics

log = require('log4js').getLogger('statistics-router')

module.exports.supplierArticleProfit = (next) ->
	result = yield statisticsController.supplierArticleProfit @request.body.start, @request.body.end
	@body = result
	yield next
