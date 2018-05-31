import App from './App'

import Coupons from 'views/coupons'
// import Coupon from 'views/coupons/item'
//
import Customers from 'views/customers'
import Customer from 'views/customers/item'
import CustomerDetails from 'views/customers/details'
import CustomerHistory from 'views/customers/history'

import NewCustomer from 'views/customers/new'
// import ExportCustomers from 'views/customers/export'
//
import Products from 'views/products'
import Product from 'views/products/item'
import NewProduct from 'views/products/new'
import ProductDetails from 'views/products/details'
import ProductArrivals from 'views/products/arrivals'
import ProductHistory from 'views/products/history'
//
import Sales from 'views/sales'
import SaleDetails from 'views/sales/item'
//
import Suppliers from 'views/suppliers'
import Supplier from 'views/suppliers/item'
import NewSupplier from 'views/suppliers/new'
import SupplierDetails from 'views/suppliers/details'
import SupplierHistory from 'views/suppliers/history'

import Statistics from 'views/statistics'

import PointOfSale from 'views/pos'

import Login from 'views/login'

let routes = [{
	path: '/',
	component: App,
	meta: {requiresAuth: true},
	name: 'home',
	children: [{
		path: 'coupons/',
		name: 'coupons',
		component: Coupons
	}, {
	// 	path: 'coupons/:id',
	// 	name: 'coupon',
	// 	component: Coupon
	// }, {
		path: 'customers/',
		name: 'customers',
		component: Customers
	}, {
		path: 'customers/new',
		name: 'customers:new',
		component: NewCustomer
	}, {
		path: 'customers/:id',
		component: Customer,
		children: [{
			path: '/',
			name: 'customers:customer',
			component: CustomerDetails
		}, {
			path: 'history',
			name: 'customers:history',
			component: CustomerHistory
		}]
	}, {
	// 	path: 'customers/export',
	// 	name: 'export-customers',
	// 	component: ExportCustomers
	// }, {
		path: 'products/',
		name: 'products',
		component: Products
	}, {
		path: 'products/new',
		name: 'products:new',
		component: NewProduct
	}, {
		path: 'products/:id',
		component: Product,
		children: [{
			path: '/',
			name: 'products:product',
			component: ProductDetails
		}, {
			path: 'arrivals',
			name: 'products:arrivals',
			component: ProductArrivals
		}, {
			path: 'history',
			name: 'products:history',
			component: ProductHistory
		}]

	}, {
		path: 'sales/',
		name: 'sales',
		component: Sales,
	}, {
		path: 'sales/:id',
		name: 'sales:sale',
		component: SaleDetails
	}, {
		path: 'suppliers/',
		name: 'suppliers',
		component: Suppliers
	}, {
		path: 'suppliers/new',
		name: 'suppliers:new',
		component: NewSupplier
	}, {
		path: 'suppliers/:id',
		component: Supplier,
		children: [{
			path: '/',
			name: 'suppliers:supplier',
			component: SupplierDetails
		}, {
			path: 'history',
			name: 'suppliers:history',
			component: SupplierHistory
		}]

	}, {
		path: 'statistics/',
		name: 'statistics',
		component: Statistics
	}, {
		path: 'pos',
		name: 'pos',
		component: PointOfSale
	}]
}, {
	path: '/login',
	component: Login
}]

export default routes
