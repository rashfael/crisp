export default {
	template: require('./navbar.jade'),
	components: {},
	data() {
		return {
			selectedCell: null
		}
	},
	methods: {

	},
	ready() {

	},
	events: {
		'cell-selected'(data) {
			this.selectedCell = data
		}
	}
}
