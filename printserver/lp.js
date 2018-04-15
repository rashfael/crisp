const { spawn } = require('child_process')

module.exports = {
	async print (data, printername) {
		return new Promise((resolve, reject) => {
			const lp = spawn('lp', ['-d', printername, '--', '-'])

			lp.stdout.on('data', (data) => {
				console.log(data.toString('ascii'))
			})

			lp.stderr.on('data', (data) => {
				console.error(data.toString('ascii'))
			})

			lp.on('close', (code) => {
				if (code !== 0) {
					return reject(new Error(code))
				}
				resolve()
			})

			lp.stdin.write(data, null, () => {
				lp.stdin.end()
			})
		})
	}
}
