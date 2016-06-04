import api from '../api'
import ListItem from './list-item'

export default {
	template: require('./index.jade'),
	components: {'list-item': ListItem},
	data() {
		return {
			items: []
		}
	},
	methods: {

	},
	created() {
		api.products.list().then((json) => this.items = json.items)
	},
	ready() {

	},
	events: {
	}
}
