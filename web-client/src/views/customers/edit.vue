<template lang="jade">
form.details-edit
	bunt-input(v-if="!isNew", name="id", :value="customer.id", label="Kundennummer", :readonly="true")
	bunt-input(name="name", v-model="customer.name", label="Name")
	bunt-input(name="name2", v-model="customer.forename", label="Vorname")
	bunt-input(name="street", v-model="customer.street", label="Straße")
	bunt-input(name="zip", v-model="customer.zip", label="PLZ")
	bunt-input(name="place", v-model="customer.place", label="Ort")
	bunt-input(name="tel", v-model="customer.tel", label="Telefon")
	bunt-input(name="email", v-model="customer.email", label="Email")
	bunt-input(name="birthday", v-model="customer.birthday", label="Geburtstag")
	bunt-input(v-if="!isNew", name="customerSince", v-model="customer.customerSince", label="Kunde seit")
	bunt-input(name="notes", v-model="customer.notes", label="Notizen")

	bunt-button#save(@click.native="submit") Speichern
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
				this.$router.push({name: 'customers:customer', params: {id: customer.id}})
			if(this.isNew)
				api.customers.create(this.customer).then(navigate)
			else
				api.customers.update(this.customer).then((customer) => this.customer = customer)

		}
	}
}
</script>
<style lang="stylus">
</style>
