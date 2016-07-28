import Customers from 'views/customers'
import Customer from 'views/customers/item'
import NewCustomer from 'views/customers/new'

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

	'/customers/' : {
		component: Customers
	},
	'/customers/:id' : {
		name: 'customer',
		component: Customer
	},
	'/customers/new' : {
		name: 'new-customer',
		component: NewCustomer
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
