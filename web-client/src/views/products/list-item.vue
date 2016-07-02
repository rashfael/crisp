<template lang="jade">
tr
	td {{item._id}}
	td {{item.name}}
	td {{item.productGroupId}}
	td {{item.supplierId}}
	td {{item.supplierProductId}}
	td {{item.cost}}
	td {{item.sale}}
	td {{item.stock}}

</template>
<script>
export default {
	components: {},
	props: ['item'],
	data() {
		return {

		}
	},
	methods: {

	},
	created() {

	},
	ready() {

	},
	events: {
	}
}
</script>
<style lang="stylus">
</style>
