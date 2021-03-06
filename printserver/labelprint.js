const iconv = require('iconv-lite')
const Decimal = require('decimal.js')
const lp = require('./lp')

module.exports = {
	async print (product, cb) {
		let content = 'ZT\nD15\nS0\nN\n'
		content += `A330,15,0,3,1,1,N,"${product.printerline1}"\n`
		content += `A330,50,0,3,1,1,N,"${product.printerline2}"\n`
		content += `A330,93,0,3,1,1,N,"${new Decimal(product.sale).toFixed(2).replace('.', ',')}"\n`
		content += `B600,15,0,3,2,4,75,B,"${product.id}"\n`
		content += `P1\n`

		await lp.print(iconv.encode(content, 'ascii'), 'labelprinter')
		// tmp.file((err, path, fd, cleanup) => {
		// 	fs.writeFile(path, content, {encoding: 'ascii'}, (err) => {
		// 		// subprocess.call(['lpr', '-P', 'labelprinter', path])
		//
		// 	})
		// })
	}
}
