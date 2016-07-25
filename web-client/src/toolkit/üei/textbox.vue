<template lang="jade">
.uei-textfield
	label(:for="name") {{label}}
	input(:type="type", :name="name", v-model="value", :disabled="disabled")
	//- - if(errors === undefined)
	//- -	var errors = {}
	//- 	.field(class=errors[name] === undefined ? '' : 'error', id=name)
	//- 		label(for=name)= labeltext + ':'
	//- 		if(required)
	//- 			span.required *
	//- 		else
	//- 			span.required
	//- 		input(type='text', name=name, value=value||locals[name])
</template>
<script>

export default {
	props: {
		type: {
			type: String,
			default: 'text'
		},
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
		disabled: {
			type: Boolean,
			default: false
		},
		icon: String,
		iconRight: {
			type: Boolean,
			default: false
		},
		// multiLine: {
		// 	type: Boolean,
		// 	default: false
		// },
		// rows: {
		// 	type: Number,
		// 	default: 2
		// },
		// maxLength: Number,
		// trimValue: {
		// 	type: Boolean,
		// 	default: true
		// },
		// autocomplete: {
		// 	type: String,
		// 	default: 'off'
		// },
		// autofocus: {
		// 	type: Boolean,
		// 	default: false
		// },
		// min: Number,
		// max: Number,
		// step: {
		// 	type: String,
		// 	default: 'any',
		// 	coerce: String
		// }
	}
}
</script>
<style lang="stylus">
.uei-textfield
	input
		input()
</style>
