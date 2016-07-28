import Pagination from '../pagination'
import api from 'lib/api'
import 'styles/list.styl'

export default {
	components: {Pagination},
	data() {
		return {
			fetchFunc: 'SET ME',
			itemsPerPage: 100,
			items: null,
			activeItem: null,
			loading: false,
			currentPage: 1,
			search: ''
		}
	},
	computed: {
		paginatedUrl() {
			if (!this.baseUrl)
				return
			let url = this.baseUrl + '?limit=' + this.itemsPerPage + '&skip=' + (this.currentPage - 1) * this.itemsPerPage
			if(this.search === '') return url
			return url + '&search=' + this.search
		},
		pages() {
			if (!this.items)
				return
			return Math.ceil(this.items.metadata.totalCount / this.itemsPerPage)
		}
	},

	watch: {
		baseUrl() {
			if (this.baseUrl) {
				this.currentPage = 1
				this.loadItems()
			} else {
				this.items = null
			}
		}
	},
	methods: {
		loadItems() {
			if (!this.baseUrl)
				return
			this.loading = true
			api.fetch(this.paginatedUrl).then((data) => {
				this.items = data
				this.loading = false
				this.$emit('items-loaded', this.items.entities, this.items)
			})
		},

		changePage(page) {
			this.currentPage = page
			this.loadItems()
		}
	},
	created() {

	},
	ready() {
		this.loadItems()
	},
	events: {
	}
}
