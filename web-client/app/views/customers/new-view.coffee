View = require 'views/base/view'

module.exports = class SupplierNewView extends View
	autoRender: true
	className: 'new-supplier'
	template: require './templates/item-form'

	events:
		'submit': 'onSubmit'

	onSubmit: =>
		data =
			_id: @$('form [name=_id]').val()
			forename: @$('form [name=forename]').val()
			name2: @$('form [name=name2]').val()
			street: @$('form [name=street]').val()
			zip: @$('form [name=zip]').val()
			place: @$('form [name=place]').val()
			tel: @$('form [name=tel]').val()
			tel2: @$('form [name=tel2]').val()
			fax: @$('form [name=fax]').val()
			email: @$('form [name=email]').val()
			birthday: @$('form [name=birthday]').val()
			notes: @$('form [name=notes]').val()
		@trigger 'new', data
		return false
