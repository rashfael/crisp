module.exports =
	auth: new (require('./auth'))()
	coupons: new (require('./coupons'))
	customers: new (require('./customers'))
	products: new (require('./products'))
	productGroups: new (require('./product-groups'))
	sales: new (require('./sales'))
	statistics: new (require('./statistics'))
	suppliers: new (require('./suppliers'))
