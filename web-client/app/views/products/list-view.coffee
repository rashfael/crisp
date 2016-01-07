View = require 'views/base/view'

module.exports = class ProductsListView extends View
	autoRender: true
	className: 'products'
	template: require './templates/list'
