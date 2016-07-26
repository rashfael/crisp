const BASE_URL = 'http://localhost:9000/api/v2/'
let headers = new Headers()
headers.append('Content-Type', 'application/json')

function request(url, body, method = 'GET') {
	let options = {
		method: method,
		headers: headers
	}
	return fetch(BASE_URL + url, options)
}

let api = {
	auth: {
		login(username, password) {
			let headers = {
				'Content-Type': 'application/json',
			}
			fetch(BASE_URL + 'login', {method: 'POST', headers: headers, body: JSON.stringify({username: username, password: password})})
			.then((response) => response.json()).then((json) => {
				localStorage.setItem('user', JSON.stringify(json))
				return Promise.resolve(json)
			})
		},
		getSession() {
			let user = JSON.parse(localStorage.getItem('user'))
			if(!user) return Promise.reject()
			headers.set('Authorization', 'Bearer ' + user.token)
			return fetch(BASE_URL + 'authenticate', {headers: headers}).then((response) => {
				if (!response.ok) {
					return Promise.reject(response.statusText)
				}
				response.json()
			})
		}
	},
	products: {
		list() {
			return request('products').then((response) => response.json())
		},
		get(id) {
			return request('products/'+id).then((response) => response.json())
		},
		update(product) {
			return api.fetch('products/'+product._id, 'PUT', JSON.stringify(product))
		},
		create(product) {
			return api.fetch('products/', 'POST', JSON.stringify(product))
		},
		generateId() {
			return api.fetch('products/generate-id')
		},
		history(id) {
			return api.fetch('products/' + id + '/history')
		}
	},
	suppliers: {
		list() {
			return api.fetch('suppliers')
		},
		get(id) {
			return api.fetch('suppliers/' + id)
		},
		update(supplier) {
			return api.fetch('suppliers/'+product._id, 'PUT', JSON.stringify(supplier))
		},
		create(supplier) {
			return api.fetch('suppliers/', 'POST', JSON.stringify(supplier))
		},
		statistics(id) {
			return api.fetch('suppliers/' + id + '/statistics')
		}
	},
	productGroups: {
		list() {
			return request('product-groups').then((response) => response.json())
		}
	}
}

api.fetch = function(url, method, body) {
	let options = {
		method: method || 'GET',
		headers,
		body
	}
	return fetch(BASE_URL + url, options).then((response) => {
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
