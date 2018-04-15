const iconv = require('iconv-lite')
const moment = require('moment')
const Decimal = require('decimal.js')
const lp = require('./lp')

const DATETIME_FORMAT = 'DD.MM.YYYY HH:mm'

const formatCurrency = function (number) {
	return number.toFixed(2).replace('.', ',')
}

const printItem = function (name, price, amount, discount) {
	let itemString = ''
	if (amount > 1)
		itemString += ` x${amount}`
	itemString += name
	itemString += formatCurrency(price).padStart(55 - name.length)
	itemString += '\n'
	if (discount > 0) {
		const dPrice = new Decimal(price)
		const dDiscount = new Decimal(discount)
		const discountedValue = dDiscount.mul(dPrice.div(new Decimal(1).sub(dDiscount)))
		itemString += ` Rabatt: ${discountedValue} (${dDiscount.mul(100)}%)\n`
	}
	itemString += '\n'
	return itemString
}

module.exports = {
	async print (sale, cb) {
		let content = '                                                            \n'
		content += '\x1B\x40' // init
		content += '\x1C\x70\x01\x00' // logo
		content += '\x1B\x21\x01' // set font
		content += '\x1B\x61\x01' // center align
		content += '\x1B\x52\x02' // german chars

		content += '\n'
		content += 'Gabriele Gepperth\n'
		content += 'Individuelle Schmuck-Kreationen\n'
		content += 'Accessoires und mehr ...\n'
		content += 'Tel. 07141/9569477\n'
		content += 'www.gepperth.de\n'

		content += '\x1b\x61\x00' // center align
		if (sale.customer !== 1) {
			content += `KNr.: ${sale.customer}\n`
			content += '\n'
		}
		content += moment(sale.date).format(DATETIME_FORMAT)
		content += '\n\n'
		content += `Bon-Nr.: ${sale.id}\n\n`
		content += 'Artikel                                           Preis\n'
		content += '-------------------------------------------------------\n'
		for (const item of sale.sale_items) {
			content += printItem(item.product_name, item.price, item.amount, item.discount)
		}
		for (const item of sale.return_items) {
			content += printItem('Rückgabe', item.price, item.amount, 0)
		}
		for (const item of sale.coupon_items) {
			content += printItem(`Gutschein ${item.id}`, item.value_change, 1, 0)
		}
		content += '-------------------------------------------------------\n'
		const sum = new Decimal(sale.price)
		content += `Gesamtrabatt: ${sale.discount * 100}%\n\n`
		content += `SUMME EUR`
		content += formatCurrency(sale.price).padStart(46)
		content += '\n\nEnthaltene MwSt\n'
		content += `19,00 % : EUR ${formatCurrency(sum.sub(sum.div(1.19)))}\n\n`
		if (sale.payment_method === 'cash') {
			content += 'BAR-Zahlung\n'
		} else {
			content += 'EC-Zahlung\n'
		}
		content += '\n\n'

		content += '\x1b\x61\x01' // center align
		content += 'Umtausch innerhalb 30 Tagen nur mit Kassenbeleg\n'
		content += 'gegen Neuware oder Gutschein \n'
		content += '\n\n\n\n\n\n\n\n'
		content += '\x1D\x56\x31' // cut

		await lp.print(iconv.encode(content, 'cp437'), 'bonprinter')

	}
}
