import remove from 'lodash/remove'
import isEmpty from 'lodash/isEmpty'

const getters = {
	ready (state, getters) {
		return state.projects && state.user.settings && getters.aggregatedRohrpostStates.ready
	}
}

export default getters
