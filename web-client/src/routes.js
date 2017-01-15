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

let routes = [{
	path: '/',
	component: App,
	meta: {requiresAuth: true},
	children: [{
		path: 'coupons/',
		name: 'coupons',
		component: Coupons
	}, {
		path: 'coupons/:id',
		name: 'coupon',
		component: Coupon
	}, {
		path: 'customers/',
		name: 'customers',
		component: Customers
	},{
		path: 'customers/:id',
		name: 'customer',
		component: Customer
	}, {
		path: 'customers/new',
		name: 'new-customer',
		component: NewCustomer
	}, {
		path: 'customers/export',
		name: 'export-customers',
		component: ExportCustomers
	}, {
		path: 'products/',
		name: 'products',
		component: Products
	}, {
		path: 'products/:id',
		name: 'product',
		component: Product
	}, {
		path: 'products/new',
		name: 'new-product',
		component: NewProduct
	}, {
		path: 'sales/',
		name: 'sales',
		component: Sales
	}, {
		path: 'sales/:id',
		name: 'sale',
		component: Sale
	}, {
		path: 'suppliers/',
		name: 'suppliers',
		component: Suppliers
	}, {
		path: 'suppliers/:id' ,
		name: 'supplier',
		component: Supplier
	}, {
		path: 'suppliers/new',
		name: 'new-supplier',
		component: NewSupplier
	}, {
		path: 'statistics/',
		name: 'statistics',
		component: Statistics
	}]
}, {
	path: '/login',
	component: Login
}]

export default routes
