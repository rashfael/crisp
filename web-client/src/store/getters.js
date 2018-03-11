const getters = {
	ready (state, getters) {
		return !!(state.suppliers && state.productGroups && state.users)
	}
}

export default getters
