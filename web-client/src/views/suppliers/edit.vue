<template lang="jade">
form.supplier-details-edit.details-edit(autocomplete="off", )
	//- bunt-input(name="_id", v-model="supplier._id", label="Lieferantennummer", :disabled="!isNew")
	bunt-input(name="name", v-model="supplier.name", label="Name")
	bunt-input(name="name2", v-model="supplier.name2", label="Name2")
	bunt-input(name="street", v-model="supplier.street", label="Straße")
	bunt-input(name="zip", v-model="supplier.zip", label="PLZ")
	bunt-input(name="place", v-model="supplier.place", label="Ort")
	bunt-input(name="tel", v-model="supplier.tel", label="Telefon")
	bunt-input(name="tel2", v-model="supplier.tel2", label="Telefon2")
	bunt-input(name="fax", v-model="supplier.fax", label="Fax")
	bunt-input(name="email", v-model="supplier.email", label="Email")
	bunt-input(name="notes", v-model="supplier.notes", label="Notizen")

	bunt-button#save(@click.native="submit") Speichern
</template>
<script>
import api from 'lib/api'

export default {
	props: {
		supplier: Object,
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
			let navigate = (supplier) =>
				this.$router.push({name: 'supplier', params: {id: supplier.id}})
			if (this.isNew)
				api.suppliers.create(this.supplier).then(navigate)
			else
				api.suppliers.update(this.supplier).then((supplier) => this.supplier = supplier)

		}
	}
}
</script>
<style lang="stylus">
.supplier-details-edit
	max-width: 420px
	margin: 36px 0 0 36px
</style>
