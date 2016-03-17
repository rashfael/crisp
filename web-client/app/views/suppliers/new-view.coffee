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
			name: @$('form [name=name]').val()
			name2: @$('form [name=name2]').val()
			street: @$('form [name=street]').val()
			zip: @$('form [name=zip]').val()
			place: @$('form [name=place]').val()
			tel: @$('form [name=tel]').val()
			tel2: @$('form [name=tel2]').val()
			fax: @$('form [name=fax]').val()
			email: @$('form [name=email]').val()
			notes: @$('form [name=notes]').val()
		@trigger 'new', data
		return false
