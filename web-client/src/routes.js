import Products from 'views/products'
import Product from 'views/products/item'
import NewProduct from 'views/products/new'

import Suppliers from 'views/suppliers'
import Supplier from 'views/suppliers/item'
import NewSupplier from 'views/suppliers/new'



let routes = {
	'/' : {
		component: Products
	},
	'/products/' : {
		component: Products
	},
	'/products/:id' : {
		name: 'product',
		component: Product
	},
	'/products/new' : {
		name: 'new-product',
		component: NewProduct
	},

	'/suppliers/' : {
		component: Suppliers
	},
	'/suppliers/:id' : {
		name: 'supplier',
		component: Supplier
	},
	'/suppliers/new' : {
		name: 'new-supplier',
		component: NewSupplier
	}
}

export default routes
