// https://github.com/shelljs/shelljs
require('shelljs/global')
env.NODE_ENV = 'production'

var path = require('path')
var ora = require('ora')
var webpack = require('webpack')
var webpackConfig = require('./webpack.prod.conf')

var spinner = ora('building for production...')
spinner.start()

// FOR FUTURE STATIC ASSET PASTING
// var assetsPath = path.resolve(__dirname, '../dist', 'static')
// rm('-rf', assetsPath)
// mkdir('-p', assetsPath)
// cp('-R', 'static/', assetsPath)

webpack(webpackConfig, function (err, stats) {
	spinner.stop()
	// catches only fatal errors
	if(err) {
		process.stderr.write(err)
		process.exit(1)
	}
	process.stdout.write(stats.toString({
		colors: true,
		modules: false,
		children: false,
		chunks: false,
		chunkModules: false
	}) + '\n')
	if(stats.hasErrors())
		process.exit(1)
})
