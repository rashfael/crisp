module.exports.formatDuration = (duration) ->
	sign = if duration >= 0 then '' else '-'
	time = Math.abs duration.asMinutes()
	minutes = Math.floor Math.abs(time) % 60
	hours = Math.floor Math.abs(time) / 60

	if hours > 0
		if minutes > 0
			return sign + hours + 'h' + minutes + 'm'
		else
			return sign + hours + 'h'
	else
		return sign + minutes + 'm'
