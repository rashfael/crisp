config = require '../../config'
request = require 'request'

tokenStore = []

module.exports = class Authenticator

	authorize: (token) ->
		yield (done) -> done()
		return tokenStore[token]

	authenticateOauth: (code) ->

		# trade code for token
		tokenBody = yield (done) ->
			request.post config.oauth.token_uri,
				form:
					client_id: config.oauth.client_id
					client_secret: config.oauth.client_secret
					code: code
					grant_type: 'authorization_code'
					redirect_uri: config.oauth.redirect_uri # Totally useless, but redirect_uri has to be valid FOR REASONS
			, (err, response, body) ->
				return done err if err?
				json = JSON.parse body
				if json.error?
					error = new Error json.error_description
					error.http_code = response.statusCode
					error.original = json
					return done error
				done null, json

		token = tokenBody.access_token
		# get user info fromg gitlab
		user = yield (done) ->
			request.get config.oauth.user_uri,
				auth:
					bearer: token
			, (err, response, body) ->
				done err, JSON.parse body

		#remember!
		tokenStore[token] =
			username: user.username

		return {token: token, username: user.username}


randtoken = require 'rand-token'

tokenStore = []

module.exports = class Authenticator

	authenticate: (user) ->
		token = randtoken.generate 32
		yield (done) -> done() # for future asyncings
		tokenStore[token] = user
		return token


	authorize: (token) ->
		yield (done) -> done()
		return tokenStore[token]
