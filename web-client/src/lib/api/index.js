const BASE_URL = 'http://localhost:9000/api/v2/'
let headers = new Headers()

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
		}
	}
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
