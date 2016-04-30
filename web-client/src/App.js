export default {
	template: require('./app.jade'),
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
