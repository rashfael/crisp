import Vue from 'vue'
import Router from 'vue-router'

import api from './api'

import routes from './routes'
import Navbar from './navbar'

Vue.use(Router)

let App = {
	template: require('./main.jade'),
	components: { navbar: Navbar },
	replace: false
}

let router = new Router()

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
