import Vue from 'vue'

const format = new Intl.NumberFormat('de-DE', {minimumFractionDigits: 2, maximumFractionDigits:2})

Vue.filter('currency', {
	// model -> view
	// formats the value when updating the input element.
	read: function(val) {
		if(val == null)
			return ''
		return format.format(val)
	},
	// view -> model
	// formats the value when writing to the data.
	write: function(val, oldVal) {
		var number = parseFloat(val.replace(/\./g,'').replace(',','.'))
		return isNaN(number) ? 0 : number
	}
})
