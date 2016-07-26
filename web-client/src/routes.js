import Products from 'views/products'
import Product from 'views/product'
import NewProduct from 'views/product/new'


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
	}
}

export default routes
