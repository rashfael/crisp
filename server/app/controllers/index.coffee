module.exports =
	auth: new (require('./auth'))()
	coupons: new (require('./coupons'))
	customers: new (require('./customers'))
	products: new (require('./products'))
	productGroups: new (require('./product-groups'))
	sales: new (require('./sales'))
	statistics: new (require('./statistics'))
	suppliers: new (require('./suppliers'))

	# taiga: new (require('./taiga'))()
	# activity: new (require('./activity'))()
	# userSettings: new (require('./user-settings'))
	# worktimeStats: new (require('./worktime-stats'))
