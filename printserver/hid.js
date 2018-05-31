const iconv = require('iconv-lite')
const HID = require('node-hid')

const CLEAR = [0x02, 0x00, 5, 0x1B, 0x5B, 0x32, 0x4A, 0x00]
const COUNTRY_CODE = [0x02, 0x00, 3, 0x1B, 0x52, 0x02]

const THANKS_DELAY = 60000
const WELCOME_DELAY = 120000

const device = new HID.HID(0x0aa7, 0x0200)
// const device = new HID.HID('0001:0013:01')
device.write(CLEAR)
device.write(COUNTRY_CODE)

let runningTimeout = null

const clear = function () {
	device.write(CLEAR)
}

const writeText = function (text) {
	const textBuffer = iconv.encode(text, 'cp437')
	const data = [ 0x02, 0x00, textBuffer.length, ...textBuffer]
	device.write(data)
}

const setCursor = function(line, pos = 0) {
	device.write([0x02, 0x00, 7, 0x1B, 0x5B, line + 0x31, 0x3B, pos + 0x31, 0x48, 0x00])
}

const formatCurrency = function (number) {
	return number.toFixed(2).replace('.', ',')
}

const hid = {
	displaySum (sum) {
		const text = formatCurrency(sum)
		clear()
		setCursor(0)
		writeText('SUMME:')
		setCursor(1)
		writeText(text.padStart(20 - text.length))
		if (runningTimeout) {
			clearTimeout(runningTimeout)
		}
		runningTimeout = setTimeout(() => {
			hid.displayThanks()
		}, THANKS_DELAY)
	},
	displayThanks () {
		clear()
		setCursor(0)
		writeText("    Vielen Dank")
		setCursor(1)
		writeText(" für Ihren Einkauf!")
		if (runningTimeout) {
			clearTimeout(runningTimeout)
		}
		runningTimeout = setTimeout(() => {
			hid.displayWelcome()
		}, WELCOME_DELAY)
	},
	displayWelcome () {
		clear()
		setCursor(0)
		writeText("   Schön, dass Sie")
		setCursor(1)
		writeText("    bei uns sind!")
	}
}

hid.displayWelcome()

module.exports = hid
