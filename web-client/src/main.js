import Vue from 'vue'
import Router from 'vue-router'
import Keen from 'keen-ui'
import 'keen-ui/dist/keen-ui.css'

import Üei from 'toolkit/üei'

import api from 'lib/api'
import routes from './routes'
import App from './App'
import humanize from 'lib/humanize'
import 'filters'
Vue.use(Router)
Vue.use(Keen)
Vue.use(Üei)

let router = new Router({
	history: true
})

router.map(routes)

router.beforeEach((transition) => {
	if (transition.to.auth && !api.auth.authenticated) {
		transition.redirect('/login')
	} else {
		transition.next()
	}
})

api.auth.getSession()
.then(humanize.fetch).then( () => {
	router.start({}, 'body')
}).catch(() => {router.start({}, 'body')})
