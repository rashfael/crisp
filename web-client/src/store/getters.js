const getters = {
	ready (state, getters) {
		return !!(state.suppliers && state.productGroups)
	}
}

export default getters
