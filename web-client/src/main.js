import Vue from 'vue'
import Router from 'vue-router'
import Buntpapier from 'buntpapier'
import moment from 'moment'

import api from 'lib/api'
import routes from './routes'
import humanize from 'lib/humanize'
import 'filters'
Vue.use(Router)
Vue.use(Buntpapier)

Vue.moment = moment
const datetimeFormat = 'YYYY-MM-DD hh:mm'
Vue.filter('datetime', (date) => {
	return moment(date).format(datetimeFormat)
})

Vue.filter('fromnow', (date) => {
	return moment(date).fromNow()
})

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

api.auth.getSession().then(() => {
	console.log('initing!')
	new Vue(Main).$mount('#v-app')
}).catch((error) => {
	console.error(error)
	new Vue(Main).$mount('#v-app')
})
