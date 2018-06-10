<template lang="jade">
form.customer-details-edit.details-edit(autocomplete="off", v-scrollbar.y="")
	bunt-input(v-if="!isNew", name="id", :value="customer.id", label="Kundennummer", :readonly="true")
	bunt-input(name="name", v-model="customer.name", label="Name")
	bunt-input(name="name2", v-model="customer.forename", label="Vorname")
	bunt-input(name="street", v-model="customer.street", label="Straße")
	bunt-input(name="zip", v-model="customer.zip", label="PLZ")
	bunt-input(name="place", v-model="customer.place", label="Ort")
	bunt-input(name="tel", v-model="customer.tel", label="Telefon")
	bunt-input(name="email", v-model="customer.email", label="Email")
	datepicker(name="birthday", v-model="customer.birthday", label="Geburtstag")
	bunt-input(v-if="!isNew", name="customerSince", v-model="customer.customer_since", label="Kunde seit", :readonly="true")
	textarea(name="notes", v-model="customer.notes", label="Notizen")
	.actions
		bunt-button#save(@click.native="submit") Speichern
</template>
<script>
import moment from 'moment'
import api from 'lib/api'
import Datepicker from 'components/datepicker'

export default {
	components: { Datepicker },
	props: {
		customer: Object,
		isNew: {
			type: Boolean,
			default: false
		}
	},
	data () {
		return {}
	},
	methods: {
		submit () {
			let navigate = (customer) =>
				this.$router.push({name: 'customers:customer', params: {id: customer.id}})
			const customer = Object.assign({}, this.customer)
			customer.birthday = customer.birthday.format('YYYY-MM-DD')
			if (this.isNew)
				api.customers.create(customer).then(navigate)
			else
				api.customers.update(customer).then((customer) => {
					customer.birthday = moment(customer.birthday)
					this.customer = customer
				})
		}
	}
}
</script>
<style lang="stylus">
.customer-details-edit
	max-width: 420px
	margin: 36px 0 36px 36px

	textarea
		flex-shrink: 0
		height: 360px
		width: 410px
		margin-bottom: 8px
</style>
