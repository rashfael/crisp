import Products from 'views/products'
import Product from 'views/product'

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
	}
}

export default routes
