const iconv = require('iconv-lite')

const lp = require('./lp')

module.exports = {
	async print (product, cb) {
		let content = 'N\n'
		content += `A330,10,0,3,1,1,N,${product.printerline1}\n`
		content += `A330,45,0,3,1,1,N,${product.printerline2}\n`
		content += `A330,88,0,3,1,1,N,${product.price.toFixed(2).replace('.', ',')}\n`
		content += `B600,10,0,3,2,4,75,B,${product.id}\n`
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
