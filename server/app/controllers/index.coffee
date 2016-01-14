module.exports =
	auth: new (require('./auth'))()
	products: new (require('./products'))
	sales: new (require('./sales'))
	# taiga: new (require('./taiga'))()
	# activity: new (require('./activity'))()
	# userSettings: new (require('./user-settings'))
	# worktimeStats: new (require('./worktime-stats'))
