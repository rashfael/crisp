<template lang="jade">
.pagination
	//- .items-per-page(v-show="showCountSelector")
	//- 	span.dropdown-text {{$t('PerPage@BaseDataGrid')}}
	//- 	quake-button(v-ref:itemsperpageselector, type="flat", has-dropdown-menu=true, :menu-options="itemsPerPageOptions", @menu-option-selected="changeItemsPerPage") {{itemsPerPage}}
	.total {{firstItem}}-{{Math.min(currentPage*itemsPerPage, total)}} von {{total}}
	ul
		li(v-for="page in slots", track-by="$index")
			span.placeholder(v-if="page == null") …
			a(href='#', v-if="page != null", @click.prevent="changePage(page)", :class="{current: page == currentPage}") {{page}}

		template(v-if="pages > 1")
			li
				a.previous(v-if="currentPage > 1", href='#', @click.prevent="changePage(Math.max(currentPage - 1, 1))", :title="Zurück"): span.material-icons &#xE5CB;
				span.placeholder(v-else): span.material-icons &#xE5CB;
			li
				a.next(v-if="currentPage < pages", href='#', @click.prevent="changePage(Math.min(currentPage + 1, pages))", :title="Weiter"): span.material-icons &#xE5CC;
				span.placeholder(v-else): span.material-icons &#xE5CC;

</template>
<script>

const SIZE = 11
const RADIUS = (SIZE-1)/2
// Range starts at 1
export default {
	props: {
		total: Number,
		pages: Number,
		currentPage: Number,
		itemsPerPage: Number,
		showCountSelector: Boolean
	},
	data() {
		return {
			// itemsPerPageOptions: [
			// 	{id: 10, text: '10'},
			// 	{id: 25, text: '25'},
			// 	{id: 50, text: '50'},
			// 	{id: 100, text: '100'},
			// ]

		}
	},
	computed: {
		slots() {
			if(this.pages <= SIZE) {
				let slots = []
				for(let i=1; i<=this.pages; i++)
					slots.push(i)
				return slots
			}

			let _preSize = Math.min(this.currentPage - 1, RADIUS)
			let _postSize = Math.min(this.pages - this.currentPage, RADIUS)
			let preSize = _preSize + RADIUS - _postSize

			let slots = new Array(SIZE)
			let activeSlot = preSize

			for(let i = activeSlot - 1; i >= 0; i--) {
				let val = this.currentPage - (activeSlot - i)
				if(i == 1 && val != 2) {
					slots[1] = null
					slots[0] = 1
					break
				}
				slots[i] = val
			}

			slots[activeSlot] = this.currentPage

			for(let i = activeSlot + 1; i < SIZE; i++) {
				let val = this.currentPage + (i - activeSlot)
				if(i == (SIZE - 2) && val != this.pages - 1) {
					slots[SIZE - 2] = null
					slots[SIZE - 1] = this.pages
					break
				}
				slots[i] = val
			}
			return slots
		},

		firstItem() {
			return (this.currentPage - 1) * this.itemsPerPage + 1
		}
	},

	methods: {
		changePage(page) {
			this.$dispatch('change-page', page)
		},
		changeItemsPerPage(option) {
			let newItemsPerPage = Number(option.id)
			let newPage = Math.ceil(this.firstItem / newItemsPerPage) || 1
			this.$dispatch('changeItemsPerPage', newItemsPerPage, newPage)
		}
	},

	ready() {
		// find menu and hack width
		// for(let child of this.$refs.itemsperpageselector.$children) {
		// 		if(child.constructor.name == 'UiMenu') {
		// 			child.$el.classList.add('items-per-page-selector')
		// 			break
		// 		}
		// }
	}
}

</script>
<style lang="stylus">
@import '~_settings'
@import '_ui'

.pagination
	display flex

	justify-content flex-end
	ul
		text-align right
		height 36px
		padding 8px

		li
			display inline-block

			.material-icons
				vertical-align bottom
				line-height inherit

		a, span.placeholder
			display block
			text-align center
			min-width 1.5em
			font-size 14px
			height 36px
			padding 0 8px
			line-height 36px
			font-weight 600

		a
			cursor pointer
			text-decoration none

			&.current
				background-color clr-grey-200

			&:hover
				background-color clr-grey-300

		span.placeholder
			cursor default
			color clr-disabled-text-light

	.total
		margin 0 16px 0 8px
		line-height 52px
		font-size 13px
		color clr-secondary-text-light
	.items-per-page
		display flex
		font-size 13px
		align-items center

.items-per-page-selector
	min-width 5em
	text-align right

span.dropdown-text
	display inline-block
	height 52px
	line-height 52px
	vertical-align baseline

.items-per-page
	height 52px
	.quake-button
		vertical-align baseline
		text-transform none

.sort-direction .quake-button, .items-per-page .quake-button
	.quake-button-content
		font-size 12px
		line-height 1.71em
	.quake-button-text
		height 24px
		line-height 24px

</style>
