import api from 'lib/api'

const actions = {
	'fetch-globals' ({dispatch}) {
		return Promise.all([dispatch('fetch-suppliers'), dispatch('fetch-product-groups')])
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
	}
}

export default actions
