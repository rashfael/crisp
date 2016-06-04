import Vue from 'vue'
import Router from 'vue-router'

import api from './api'
import routes from './routes'
import App from './App'

Vue.use(Router)

let router = new Router({
	history: true
})

router.map(routes)
let init = (promise) => {
	promise.then((user) => {
		router.start(App, 'body')
	}).catch(() => {
		console.log('nope')
		init(api.auth.login('herp', 'derp'))
	})

}
init(api.auth.getSession())
