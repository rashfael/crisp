_ = require 'lodash'

View = require 'views/base/view'
translations = require 'translations'

module.exports = class SaleItemView extends View
	autoRender: true
	className: 'sale'
	template: require './templates/item'
