<template lang="jade">

form(@submit.prevent="submit")
	uei-textbox(name="_id", :value.sync="product._id", label="Artikelnummer", :disabled="!new")
	button(v-if="new") Generieren
	uei-textbox(name="name", :value.sync="product.name", label="Name")
	uei-select(name="productGroupId", label="Produktgruppe", :value.sync="product.productGroupId", :options="humanize.productGroups", text-key="name", value-key="_id")
	uei-select(name="productGroupId", label="Lieferant", :value.sync="product.supplierId", :options="humanize.suppliers", text-key="name", value-key="_id")
	uei-textbox(name="supplierProductId", :value.sync="product.supplierProductId", label="Name")
	uei-textbox(name="name", :value.sync="product.name", label="Lieferantennummer")
	uei-textbox(name="printerline1", :value.sync="product.printerline1", label="Druckzeile 1")
	uei-textbox(name="printerline2", :value.sync="product.printerline2", label="Druckzeile 2")
	uei-textbox(name="cost", :value.sync="product.cost | currency", label="EK")
	uei-textbox(name="sale", :value.sync="product.sale | currency", label="VK")
	//- ui-select
	//- .field
	//- 	label(for='_id') Artikelnummer:
	//- 	input(type='text', id='_id', name='_id', value=_id, readonly=_id!=null)
	//- 	if(_id == null)
	//- 		button#generate Generieren
	//- +textfield('name', 'Name')
	//- .field
	//- 	label(for='productGroupId') Produktgruppe:
	//- 	select(id='productGroupId', name='productGroupId')
	//- 		for productGroup in translations.productGroups
	//- 			if productGroupId == productGroup._id
	//- 				option(value=productGroup._id, selected)= productGroup.name
	//- 			else
	//- 				option(value=productGroup._id)= productGroup.name
	//- .field
	//- 	label(for='supplierId') Lieferant:
	//- 	select(id='supplierId', name='supplierId')
	//- 		for supplier in translations.suppliers
	//- 			if supplierId == supplier._id
	//- 				option(value=supplier._id, selected)= supplier.name
	//- 			else
	//- 				option(value=supplier._id)= supplier.name
	//- +textfield('supplierProductId', 'Lieferantennummer')
	//- +textfield('printerline1', 'Druckzeile 1')
	//- +textfield('printerline1', 'Druckzeile 2')
	//- +textfield('cost', 'EK', cost?cost.toLocaleString('de-DE', {minimumFractionDigits: 2}):'')
	//- +textfield('sale', 'VK', sale?sale.toLocaleString('de-DE', {minimumFractionDigits: 2}):'')
	//-
	button(type='submit') Speichern
</template>
<script>
import api from 'lib/api'
import humanize from 'lib/humanize'

export default {
	props: {
		product: Object,
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
		submit() {
			api.products.update(this.product)
		}
	}
}
</script>
<style lang="stylus">
</style>
