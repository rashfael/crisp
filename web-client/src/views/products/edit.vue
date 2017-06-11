<template lang="jade">

form.details-edit(@submit.prevent="submit")
	.product-id
		bunt-input(name="_id", :value.sync="product._id", label="Artikelnummer", :disabled="!isNew")
		ui-button.generate(v-if="isNew", @click.prevent="generateId") Generieren
	bunt-input(name="name", :value.sync="product.name", label="Name")
	uei-select(name="productGroupId", label="Produktgruppe", :value.sync="product.productGroupId", :options="humanize.productGroups", text-key="name", value-key="_id")
	uei-select(name="supplierId", label="Lieferant", :value.sync="product.supplierId", :options="humanize.suppliers", text-key="name", value-key="_id")
	bunt-input(name="supplierProductId", :value.sync="product.supplierProductId", label="Lieferantennummer")
	bunt-input(name="printerline1", :value.sync="product.printerline1", label="Druckzeile 1")
	bunt-input(name="printerline2", :value.sync="product.printerline2", label="Druckzeile 2")
	bunt-input(name="cost", :value.sync="product.cost | pure-currency", label="EK")
	bunt-input(name="sale", :value.sync="product.sale | pure-currency", label="VK")

	button(type='submit') Speichern
</template>
<script>
import api from 'lib/api'
import humanize from 'lib/humanize'

export default {
	props: {
		product: {
			type: Object,
			default: {
			}
		},
		isNew: {
			type: Boolean,
			default: false
		}
	},
	data() {
		return {
			humanize
		}
	},
	methods: {
		generateId() {
			api.products.generateId().then((id) =>{
				this.product._id = id
			})
		},
		submit() {
			let navigate = (product) =>
				this.$router.go({name: 'product', params: {id: product._id}})
			if(this.isNew)
				api.products.create(this.product).then((product) => this.product = product)
			else
				api.products.update(this.product).then(navigate)
		}
	}
}
</script>
<style lang="stylus">
.product-id
	display flex
</style>
