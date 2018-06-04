<template lang="jade">
form.product-details-edit.details-edit(autocomplete="off", v-scrollbar.y="")
	.product-id
		bunt-input(name="_id", v-model="product.id", label="Artikelnummer", :disabled="!isNew || autogenerate")
		bunt-switch(v-if="isNew", name="autogenerate", v-model="autogenerate", label="Generieren")
	bunt-input(name="name", v-model="product.name", label="Name")
	bunt-select(name="productGroupId", label="Produktgruppe", v-model="product.product_group", :options="productGroups", option-label="name")
	bunt-select(name="supplierId", label="Lieferant", v-model="product.supplier", :options="suppliers", option-label="name")
	bunt-input(name="supplierProductId", v-model="product.supplier_product_id", label="Lieferantennummer")
	bunt-input(name="printerline1", v-model="product.printerline1", label="Druckzeile 1")
	bunt-input(name="printerline2", v-model="product.printerline2", label="Druckzeile 2")
	decimal-input(name="cost", v-model="product.cost", label="EK", :fixed="2")
	decimal-input(name="sale", v-model="product.sale", label="VK", :fixed="2")
	.actions
		bunt-button#save(@click.native="submit") Speichern
		bunt-button.print(@click="printLabel") Drucken

</template>
<script>
import { mapState } from 'vuex'
import api from 'lib/api'
import ioApi from 'lib/api/io'

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
	data () {
		return {
			humanize,
			autogenerate: false
		}
	},
	computed: {
		...mapState(['productGroups', 'suppliers'])
	},
	methods: {
		generateId () {
			api.products.generateId().then((id) => {
				this.product._id = id
			})
		},
		submit () {
			let navigate = (product) =>
				this.$router.push({name: 'products:product', params: {id: product.id}})
			if (this.isNew) {
				if (this.product.id === '' || this.autogenerate) {
					this.product.id = undefined
				}
				api.products.create(this.product).then(navigate)
			}
			else
				api.products.update(this.product).then(navigate)
		},
		printLabel () {
			ioApi.print.label(this.product)
		}
	}
}
</script>
<style lang="stylus">
.product-details-edit
	max-width: 420px
	margin: 36px 0 36px 36px
</style>
