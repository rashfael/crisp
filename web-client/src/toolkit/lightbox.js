import template from './lightbox.jade'

export default {
	template: template,
	props: {
		show: Boolean
	},
	watch: {
		show() {
			if(this.show) {
				window.addEventListener('keyup', this.hide)
			}
			else {
				window.removeEventListener('keyup', this.hide)
			}
		}
	},

	methods: {
		hide() {
			this.show = false
		}
	}
}
