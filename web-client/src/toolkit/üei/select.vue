<template lang="jade">
.uei-select
	label(:for="name") {{label}}
	select(:name='name', v-model="value")
		option(v-for="option in options", :value="option[valueKey]") {{option[textKey]}}
</template>
<script>

export default {
	props: {
		id: String,
		name: {
			type: String,
			required: true
		},
		label: String,
		placeholder: String,
		value: {
			type: [String, Number],
			default: '',
			twoWay: true
		},
		options: {
			type: Array
		},
		valueKey: {
			type: String,
			default: 'value'
		},
		textKey: {
			type: String,
			default: 'text'
		}
	}
}
</script>
<style lang="stylus">
.uei-textfield
	input
		input()
</style>
