import Vue from 'vue'
import Router from 'vue-router'

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
router.start(App, 'body')
