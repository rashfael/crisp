import App from './App'

import Coupons from 'views/coupons'
import Coupon from 'views/coupons/item'

import Customers from 'views/customers'
import Customer from 'views/customers/item'
import NewCustomer from 'views/customers/new'
import ExportCustomers from 'views/customers/export'

import Products from 'views/products'
import Product from 'views/products/item'
import NewProduct from 'views/products/new'

import Sales from 'views/sales'
import Sale from 'views/sales/item'

import Suppliers from 'views/suppliers'
import Supplier from 'views/suppliers/item'
import NewSupplier from 'views/suppliers/new'

import Statistics from 'views/statistics'

import Login from 'views/login'

let routes = {
	'/' : {
		component: App,
		subRoutes: {
			// '/' : {
			// 	component: Products
			// },

			'coupons/' : {
				name: 'coupons',
				component: Coupons
			},
			'coupons/:id' : {
				name: 'coupon',
				component: Coupon
			},

			'customers/' : {
				name: 'customers',
				component: Customers
			},
			'customers/:id' : {
				name: 'customer',
				component: Customer
			},
			'customers/new' : {
				name: 'new-customer',
				component: NewCustomer
			},
			'customers/export' : {
				name: 'export-customers',
				component: ExportCustomers
			},

			'products/' : {
				name: 'products',
				component: Products
			},
			'products/:id' : {
				name: 'product',
				component: Product
			},
			'products/new' : {
				name: 'new-product',
				component: NewProduct
			},

			'sales/' : {
				name: 'sales',
				component: Sales
			},
			'sales/:id' : {
				name: 'sale',
				component: Sale
			},

			'suppliers/' : {
				name: 'suppliers',
				component: Suppliers
			},
			'suppliers/:id' : {
				name: 'supplier',
				component: Supplier
			},
			'suppliers/new' : {
				name: 'new-supplier',
				component: NewSupplier
			},

			'statistics/' : {
				name: 'statistics',
				component: Statistics
			}
		},
		auth: true
	},
	'/login' : {
		component: Login
	}
}

export default routes
