import template from './foldout-text.jade'

export default {
	template: template,
	props: {
		content: String,
		foldedHeight: {
			type: Number,
			default: 100
		}
	},
	data() {
		return {
			contentHeight: null
		}
	},

	ready() {
		this.updateContentHeight()
	},
	
	watch: {
		content() {
			this.updateContentHeight()
		}
	},

	methods: {
		expand() {
			let foldoutEl = this.$el.parentNode.querySelector('.foldout')
			setTimeout(function() { foldoutEl.style.height = '' }, 1000)
			foldoutEl.style.height = this.contentHeight + 'px'
			this.contentHeight = null
		},
		
		updateContentHeight() {
			let foldoutEl = this.$el.parentNode.querySelector('.foldout')
			if (foldoutEl) {
				foldoutEl.style.height = ''
				let contentHeight = foldoutEl.scrollHeight

				if (contentHeight > this.foldedHeight) {
					this.contentHeight = contentHeight
					foldoutEl.style.height = (this.foldedHeight - 20) + 'px'
				} else {
					this.contentHeight = null
				}
			}
		}
	}
}
