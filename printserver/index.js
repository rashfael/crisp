const Koa = require('koa')
const bodyparser = require('koa-bodyparser')
const cors = require('@koa/cors')
const Router = require ('koa-router')

const app = new Koa()
const router = new Router()

const bonprint = require('./bonprint')
const labelprint = require('./labelprint')

// router.post('/print/sale', (ctx, next) => {
//
// })
//
// router.post('/print/label', (ctx, next) => {
//
// })
//
//
// app.use(bodyparser())
// app.use(cors({
// 	origin (ctx) {
// 		console.log(ctx)
// 	}
// }))
// app.use(router.routes()).use(router.allowedMethods())
//
//
// app.listen(3000)

bonprint.print({
	id: 1234,
	date: Date.now(),
	customer: 5,
	discount: 0.05,
	price: 46.54,
	payment_method: 'cash',
	sale_items: [{
		product_name: 'derpy derp',
		price: 12.45,
		amount: 1,
		discount: 0
	}],
	return_items: [],
	coupon_items: []
})
