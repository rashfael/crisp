View = require 'views/base/view'


module.exports = class PaginationView extends View
	autoRender: false
	className: 'pagination'
	template: require './templates/pagination'

	listen:
		'change model': 'render'

	events:
		'click .first': 'onFirst'
		'click .previous': 'onPrevious'
		'click .page': 'onPage'
		'click .next': 'onNext'
		'click .last': 'onLast'

	onFirst: (event) =>
		event.preventDefault()
		@publishEvent 'pagination:page', 0

	onPrevious: (event) =>
		event.preventDefault()
		@publishEvent 'pagination:page', @currentPage - 1

	onPage: (event) =>
		event.preventDefault()
		@publishEvent 'pagination:page', event.target.dataset.page

	onNext: (event) =>
		event.preventDefault()
		@publishEvent 'pagination:page',  @currentPage + 1

	onLast: (event) =>
		event.preventDefault()
		@publishEvent 'pagination:page', @pageCount - 1


	getTemplateData: =>
		data = super()
		pageCount = Math.ceil data.totalCount / data.limit
		@pageCount = pageCount
		currentPage = data.skip / data.limit
		@currentPage = currentPage # laaaaazy
		firstVisible = Math.max(currentPage - 5 - Math.max(currentPage + 5 - pageCount, 0), 0)
		lastVisible = Math.min(currentPage + 5 - Math.min(currentPage - 5, 0), pageCount)
		data.pageCount = pageCount
		data.currentPage = currentPage
		data.firstVisible = firstVisible
		data.lastVisible = lastVisible
		return data
