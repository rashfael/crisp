Schema = global.mongoose.Schema

Inventory = new Schema {
	_id: String
	date:
		type: Date
		default: Date.now
}

module.exports.Inventory = Inventory
