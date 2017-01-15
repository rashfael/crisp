<template lang="jade">

form.details-edit(@submit.prevent="submit")
	uei-textbox(name="_id", :value.sync="supplier._id", label="Lieferantennummer", :disabled="!isNew")
	uei-textbox(name="name", :value.sync="supplier.name", label="Name")
	uei-textbox(name="name2", :value.sync="supplier.name2", label="Name2")
	uei-textbox(name="street", :value.sync="supplier.street", label="Straße")
	uei-textbox(name="zip", :value.sync="supplier.zip", label="PLZ")
	uei-textbox(name="place", :value.sync="supplier.place", label="Ort")
	uei-textbox(name="tel", :value.sync="supplier.tel", label="Telefon")
	uei-textbox(name="tel2", :value.sync="supplier.tel2", label="Telefon2")
	uei-textbox(name="fax", :value.sync="supplier.fax", label="Fax")
	uei-textbox(name="email", :value.sync="supplier.email", label="Email")
	uei-textbox(name="notes", :value.sync="supplier.notes", label="Notizen")

	button(type='submit') Speichern
</template>
<script>
import api from 'lib/api'

export default {
	props: {
		supplier:Object,
		isNew: {
			type: Boolean,
			default: false
		}
	},
	data() {
		return {}
	},
	methods: {
		submit() {
			let navigate = (supplier) =>
				this.$router.go({name: 'supplier', params: {id: supplier._id}})
			if(this.isNew)
				api.suppliers.create(this.supplier).then((supplier) => this.supplier = supplier)
			else
				api.suppliers.update(this.supplier).then(navigate)

		}
	}
}
</script>
<style lang="stylus">
</style>
