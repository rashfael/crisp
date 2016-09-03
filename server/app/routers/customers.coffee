moment = require 'moment'
customersController = require('../controllers').customers
salesController = require('../controllers').sales

log = require('log4js').getLogger('customers-router')

module.exports.create = (next) ->
	saved = yield customersController.create @request.body
	@status = 201
	@body = saved
	yield next

module.exports.list = (next) ->
	query = {}

	if @query.search?
		searchNumber = parseInt(@query.search)
		if not isNaN(searchNumber)
			query = {_id: searchNumber}
		else
			query =
				$or: [
					name:
						$regex: @query.search
						$options: 'i'
				,
					forename:
						$regex: @query.search
						$options: 'i'
				]

	options =
		limit: parseInt(@query?.limit) or 100
		skip: parseInt(@query?.skip) or 0
		sort: '_id'

	[list, count] = yield [
		customersController.find query, @request.body?.projection, options
		customersController.count query
	]
	@body =
		items: list
		metadata:
			totalCount: count
			limit: options.limit
			skip: options.skip

	yield next

module.exports.read = (next) ->
	item = yield customersController.findOne _id: @params.id
	@body = item
	yield next

module.exports.history = (next) ->
	query =
		customerId: parseInt @params.id
	options =
		sort: {date: -1}
	# TODO redo with aggregation
	sales = yield salesController.find query, {_id: 1, date: 1, price: 1, discount: 1}, options

	@body = sales
	yield next

module.exports.update = (next) ->
	item = yield customersController.update @params.id, @request.body
	@body = item
	yield next

module.exports.delete = (next) ->
	result = yield customersController.remove _id: @params.id
	if result.result.n is 0
		@status = 404
	else
		@status = 204
	yield next

module.exports.export = (next) ->
	query =
		$where: ''
	if @query.hasEmail? and @query.hasEmail is 'true'
		query.$where = "this.email != undefined && this.email !=  ''"
	else
		query.$where = "(this.email == undefined || this.email ==  '') &&( this.zip != undefined && this.zip != '')"

	if @query.birthday
		query.$where += "&& new Date(this.birthday).getMonth() == #{@query.birthday-1}" # TODO injection

	options =
		sort:
			birthday: 1
			zip: 1
	console.log(query)
	result = yield customersController.find query, null, options

	# if filter? && filter.birthday?
	# 	data.sort (a,b) -> return a.birthday.getDate() - b.birthday.getDate()
	csvData = '#,Titel,Name,Vorname,Straße,ZIP,Ort,Telefon,Email,Geburtstag\n'
	console.log(result.length)
	for c in result
		if c.birthday?
			c.birthdayFormat = moment(c.birthday).format('DD.MM.YYYY')
		csvData += "#{c._id},#{c.title || ''},#{c.name || ''},#{c.forename || ''},\"#{c.street || ''}\",#{c.zip || ''},\"#{c.place || ''}\",#{c.tel || ''},#{c.email || ''},#{c.birthdayFormat || ''}\n"
	@body =
		csv: csvData
	# @set('Content-Type', 'text/csv')
	# @set('Content-Disposition': 'attachment; filename="kunden.csv"')
