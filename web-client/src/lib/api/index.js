import config from 'config'
import querystring from 'querystring'

const BASE_URL = config.api.baseUrl
let headers = new Headers()
headers.append('Content-Type', 'application/json')

function request(url, body, method = 'GET') {
	let options = {
		method: method,
		headers: headers
	}
	return fetch(BASE_URL + url, options)
}

export function cleanQuery (object) {
	Object.keys(object).forEach(key => !object[key] && delete object[key])
	return object
}

let api = {
	auth: {
		authenticated: false,
		login(username, password) {
			return fetch(BASE_URL + 'token/', {method: 'POST', headers: headers, body: JSON.stringify({username: username, password: password})})
			.then((response) => {
				if (!response.ok)
					return Promise.reject()
				return response.json()
			}).then((json) => {
				localStorage.setItem('user', JSON.stringify(json))
				api.auth.authenticated = true
				headers.set('Authorization', 'Bearer ' + json.token)
				return Promise.resolve(json)
			})
		},
		getSession() {
			let user = JSON.parse(localStorage.getItem('user'))
			if(!user) return Promise.reject()
			headers.set('Authorization', 'Token ' + user.token)
			api.auth.authenticated = true
			return Promise.resolve()
			// return fetch(BASE_URL + 'authenticate', {headers: headers}).then((response) => {
			// 	if (!response.ok) {
			// 		return Promise.reject(response.statusText)
			// 	}
			//
			// 	response.json()
			// })
		}
	},
	coupons: {
		list() {
			return api.fetch(`coupons`)
		},
		get(id) {
			return api.fetch(`coupons/${id}`)
		}
	},
	customers: {
		list (search) {
			const query = {
				search: search
			}
			const qs = querystring.stringify(cleanQuery(query))
			return api.fetch(`customers/?${qs}`)
		},
		get (id) {
			return api.fetch(`customers/${id}`)
		},
		update (customer) {
			return api.fetch(`customers/${customer._id}`, 'PUT', JSON.stringify(customer))
		},
		create (customer) {
			return api.fetch('customers/', 'POST', JSON.stringify(customer))
		},
		history (id) {
			return api.fetch(`customers/${id}/history`)
		},
		csvExport (birthday, hasEmail) {
			return api.fetch(`customers/export?birthday=${birthday || ''}&hasEmail=${hasEmail}`)
		}
	},
	products: {
		list (search) {
			const query = {
				search: search
			}
			const qs = querystring.stringify(cleanQuery(query))
			return api.fetch(`products/?${qs}`)
		},
		get (id) {
			return request(`products/${id}/`).then((response) => response.json())
		},
		update (product) {
			return api.fetch(`products/${product._id}`, 'PUT', JSON.stringify(product))
		},
		create (product) {
			return api.fetch('products/', 'POST', JSON.stringify(product))
		},
		generateId () {
			return api.fetch('products/generate-id')
		},
		history (id) {
			return api.fetch(`products/${id}/history`)
		},
		addArrival (id, amount) {
			const data = {
				amount,
				shop: 'Ludwigsburg'
			}
			return api.fetch(`products/${id}/arrival`, 'POST', JSON.stringify(data))
		}
	},
	sales: {
		list (search) {
			return api.fetch(`sales/?search=${search}`)
		},
		get (id) {
			return api.fetch(`sales/${id}`)
		},
		create (sale) {
			return api.fetch(`sales/`, 'POST', JSON.stringify(sale))
		}
	},
	suppliers: {
		list (limit) {
			return api.fetch(`suppliers/`)
		},
		get (id) {
			return api.fetch(`suppliers/${id}/`)
		},
		update (supplier) {
			return api.fetch(`suppliers/${product._id}`, 'PUT', JSON.stringify(supplier))
		},
		create (supplier) {
			return api.fetch('suppliers/', 'POST', JSON.stringify(supplier))
		},
		statistics (id) {
			return api.fetch(`suppliers/${id}/statistics`)
		}
	},
	productGroups: {
		list() {
			return request('product-groups/').then((response) => response.json())
		}
	},
	statistics: {
		supplierArticleProfit(start, end) {
			return api.fetch(`statistics/supplier-article-profit`, 'POST', JSON.stringify({start: start, end: end}))
		}
	}
}

api.fetch = function (url, method, body) {
	let options = {
		method: method || 'GET',
		headers,
		body
	}
	return fetch(url.startsWith('http') ? url : BASE_URL + url, options).then((response) => {
		return response.json().then((json) => {
			if (!response.ok)
				return Promise.reject(json)

			return Promise.resolve(json)
		})
	}).catch((error) => {
		// mediator.emit('fetch-error', error)
		return Promise.reject(error)
	})
}

export default api


// 	_getSession: =>
// 		user = JSON.parse localStorage.getItem 'user'
// 		return @_showLoginPrompt() unless user?
// 		$.ajax
// 			url: '/api/v2/authenticate'
// 			headers:
// 				Authorization: 'Bearer ' + user.token
// 			dataType: 'json'
// 			success: (user) =>
// 				if user?
// 					@_loginSuccess user
// 				else
// 					@_showLoginPrompt()
// 			error: () =>
// 				@_showLoginPrompt()
//
// 	_loginSuccess: (user) =>
// 		mediator.user = new User user
// 		localStorage.setItem 'user', JSON.stringify user
// 		$.ajaxSetup
// 			beforeSend: (xhr, settings) ->
// 				if settings.url[0] is '/'
// 					xhr.setRequestHeader "Authorization","Bearer #{user.token}"
//
// 		@publishEvent '!auth:success'
// 		return
//
// 	_showLoginPrompt: =>
// 		mediator.user = new User()
// 		@view = new LoginView
// 			model: mediator.user
// 		@listenTo @view, 'login', (password) =>
// 			@view.dispose()
// 			# @_loginSuccess(mediator.user)
// 			data =
// 				username: mediator.user.get 'username'
// 				password: password
// 			$.post '/api/v2/login', data, (user) =>
// 				@_loginSuccess user
//
// 		#@view = new LoginView()
