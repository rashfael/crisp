<template lang="jade">

form.details-edit(@submit.prevent="submit")
	bunt-input(name="id", :value.sync="customer.id", label="Kundennummer", :readonly="!isNew")
	bunt-input(name="name", :value.sync="customer.name", label="Name")
	bunt-input(name="name2", :value.sync="customer.forename", label="Vorname")
	bunt-input(name="street", :value.sync="customer.street", label="Straße")
	bunt-input(name="zip", :value.sync="customer.zip", label="PLZ")
	bunt-input(name="place", :value.sync="customer.place", label="Ort")
	bunt-input(name="tel", :value.sync="customer.tel", label="Telefon")
	bunt-input(name="email", :value.sync="customer.email", label="Email")
	bunt-input(name="birthday", :value.sync="customer.birthday", label="Geburtstag")
	bunt-input(name="customerSince", :value.sync="customer.customerSince", label="Kunde seit")
	bunt-input(name="notes", :value.sync="customer.notes", label="Notizen")

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
