config = require '../../config'
mongoose = require 'mongoose'
Cashier = mongoose.model 'Cashier'

randtoken = require 'rand-token'

tokenStore = {}

module.exports = class Authenticator

	authenticate: (user) ->
		token = randtoken.generate 32
		yield (done) -> done() # for future asyncings
		cashier = yield Cashier.findOne({_id: user.username}).exec()
		if cashier? and cashier.password is user.password
			user.token = token
			user.name = cashier.name
			user.forename = cashier.forename
			tokenStore[token] = user
			return user
		else
			return

	authorize: (token) ->
		yield (done) -> done()
		user = tokenStore[token]
		return null if not user?
		ret = {
			token: user.token
			name: user.name
			forename: user.forename
		}
		return ret
