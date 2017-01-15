<template lang="jade">

form.details-edit(@submit.prevent="submit")
	uei-textbox(name="_id", :value.sync="customer._id", label="Kundennummer", :readonly="!isNew")
	uei-textbox(name="name", :value.sync="customer.name", label="Name")
	uei-textbox(name="name2", :value.sync="customer.forename", label="Vorname")
	uei-textbox(name="street", :value.sync="customer.street", label="Straße")
	uei-textbox(name="zip", :value.sync="customer.zip", label="PLZ")
	uei-textbox(name="place", :value.sync="customer.place", label="Ort")
	uei-textbox(name="tel", :value.sync="customer.tel", label="Telefon")
	uei-textbox(name="email", :value.sync="customer.email", label="Email")
	uei-textbox(name="birthday", :value.sync="customer.birthday", label="Geburtstag")
	uei-textbox(name="customerSince", :value.sync="customer.customerSince", label="Kunde seit")
	uei-textbox(name="notes", :value.sync="customer.notes", label="Notizen")

	button(type='submit') Speichern
</template>
<script>
import api from 'lib/api'

export default {
	props: {
		customer: Object,
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
			let navigate = (customer) =>
				this.$router.go({name: 'customer', params: {id: customer._id}})
			if(this.isNew)
				api.customers.create(this.customer).then((customer) => this.customer = customer)
			else
				api.customers.update(this.customer).then(navigate)

		}
	}
}
</script>
<style lang="stylus">
</style>
