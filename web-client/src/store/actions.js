import api from 'lib/api'

const actions = {
	'fetch-globals' ({dispatch}) {
		return Promise.all([dispatch('fetch-suppliers'), dispatch('fetch-product-groups'), dispatch('fetch-users')])
	},
	'fetch-suppliers' ({commit}) {
		return api.suppliers.list().then((suppliers) => {
			commit('SET_SUPPLIERS', suppliers.results)
		})
	},
	'fetch-product-groups' ({commit}) {
		return api.productGroups.list().then((productGroups) => {
			commit('SET_PRODUCT_GROUPS', productGroups.results)
		})
	},
	'fetch-users' ({commit}) {
		return api.users.list().then((users) => {
			commit('SET_USERS', users.results)
		})
	}
}

export default actions
