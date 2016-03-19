moment = require 'moment'

dateFormat = 'DD. MM. YYYY'
dateTimeFormat = 'DD. MM. YYYY hh:mm'

module.exports =
	formatCurrency: (value) ->
		return '' unless value?
		return value.toLocaleString 'de-DE', minimumFractionDigits: 2

	formatDate: (value) ->
		return '' unless value?
		moment(value).format dateFormat

	formatDateTime: (value) ->
		return '' unless value?
		moment(value).format dateTimeFormat

	formatPercentage: (value) ->
		return '' unless value?
		return value/100 + ' %'
