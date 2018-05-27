import config from 'config'

const BASE_URL = config.io.baseUrl
let headers = new Headers()
headers.append('Content-Type', 'application/json')

export function cleanQuery (object) {
	Object.keys(object).forEach(key => !object[key] && delete object[key])
	return object
}

let api = {
	print: {
		sale (sale) {
			return api.fetch(`print/sale`, 'POST', JSON.stringify(sale))
		},
		label (product) {
			return api.fetch(`print/label`, 'POST', JSON.stringify(product))
		}
	}
}

api.fetch = function (url, method, body) {
	let options = {
		method: method || 'GET',
		headers,
		body
	}
	return window.fetch(url.startsWith('http') ? url : BASE_URL + url, options).then((response) => {
		if (!response.ok)
			return Promise.reject(response)
		return Promise.resolve(response)
	})
}

export default api
