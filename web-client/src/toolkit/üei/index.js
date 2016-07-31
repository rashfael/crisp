import ÜeiTextbox from './textbox'
import ÜeiSelect from './select'

const Üei = {
	ÜeiSelect,
	ÜeiTextbox,
	install(Vue) {
		Vue.component('uei-select', ÜeiSelect)
		Vue.component('uei-textbox', ÜeiTextbox)
	}
}

module.exports = Üei
