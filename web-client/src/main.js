import Vue from 'vue'
import Router from 'vue-router'
import Buntpapier from 'buntpapier'
import moment from 'moment'

import api from 'lib/api'
import store from 'store'
import routes from './routes'
import 'components/filters'
import 'components/directives'
import DecimalInput from 'components/decimal-input'
import PercentageInput from 'components/percentage-input'

Vue.use(Router)
Vue.use(Buntpapier)
Vue.component('decimal-input', DecimalInput)
Vue.component('percentage-input', PercentageInput)

Vue.moment = moment

let router = new Router({
	mode: 'history',
	routes: routes
})

router.beforeEach((to, from, next) => {
	if (to.matched.some(record => record.meta.requiresAuth) && !api.auth.authenticated) {
		next({path: '/login'})
	} else {
		next()
	}
})

import Main from './main.vue'
Main.router = router
Main.store = store

window.api = api

api.auth.getSession().then(() => {
	console.log('initing!')
	new Vue(Main).$mount('#v-app')
}).catch((error) => {
	console.error(error)
	new Vue(Main).$mount('#v-app')
})
