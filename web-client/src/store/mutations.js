const mutations = {
	SET_SUPPLIERS (state, suppliers) {
		state.suppliers = suppliers
		suppliers.reduce((acc, doc) => { acc[doc.id] = doc; return acc }, state.suppliersMap)
	},
	SET_PRODUCT_GROUPS (state, productGroups) {
		state.productGroups = productGroups
		productGroups.reduce((acc, doc) => { acc[doc.id] = doc; return acc }, state.productGroupsMap)
	},
	SET_USERS (state, users) {
		state.users = users
		users.reduce((acc, doc) => { acc[doc.id] = doc; return acc }, state.usersMap)
	}
}

export default mutations
