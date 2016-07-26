<template lang="jade">

form(@submit.prevent="submit")
	.product-id
		uei-textbox(name="_id", :value.sync="product._id", label="Artikelnummer", :disabled="!new")
		ui-button.generate(v-if="new", @click.prevent="generateId") Generieren
	uei-textbox(name="name", :value.sync="product.name", label="Name")
	uei-select(name="productGroupId", label="Produktgruppe", :value.sync="product.productGroupId", :options="humanize.productGroups", text-key="name", value-key="_id")
	uei-select(name="supplierId", label="Lieferant", :value.sync="product.supplierId", :options="humanize.suppliers", text-key="name", value-key="_id")
	uei-textbox(name="supplierProductId", :value.sync="product.supplierProductId", label="Lieferantennummer")
	uei-textbox(name="printerline1", :value.sync="product.printerline1", label="Druckzeile 1")
	uei-textbox(name="printerline2", :value.sync="product.printerline2", label="Druckzeile 2")
	uei-textbox(name="cost", :value.sync="product.cost | currency", label="EK")
	uei-textbox(name="sale", :value.sync="product.sale | currency", label="VK")

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
		new: {
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
			if(this.new)
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
