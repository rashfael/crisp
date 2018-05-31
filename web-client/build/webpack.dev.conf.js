var webpack = require('webpack')
var merge = require('webpack-merge')
var path = require('path')
var projectRoot = path.resolve(__dirname, '../')
var baseWebpackConfig = require('./webpack.base.conf')
var HtmlWebpackPlugin = require('html-webpack-plugin')

// add hot-reload related code to entry chunks
Object.keys(baseWebpackConfig.entry).forEach(function (name) {
	baseWebpackConfig.entry[name] = ['./build/dev-shim'].concat(baseWebpackConfig.entry[name])
})

module.exports = merge(baseWebpackConfig, {
	mode: 'development',
	module: {
		rules: [
			{ test: /\.vue$/, use: ['vue-loader']},
			{ test: /\.css$/, use: ['style-loader','css-loader'] },
			{ test: /\.styl|\.stylus$/, use: [
				'vue-style-loader',
				'css-loader',
				{
					loader: 'stylus-loader',
					options: {
						use: [require('rupture')(), require('buntpapier/stylus')()],
					},
				},
			] }
		]
	},
	resolve: {
		alias: {
			'config': path.resolve(projectRoot, 'config.dev.js'),
		}
	},
	output: {
		pathinfo: true
	},
	plugins: [
		new webpack.DefinePlugin({
			'ENV_DEVELOPMENT': true,
			'process.env': {
				NODE_ENV: '"development"'
			},
			TARGET: '"stage"'
		}),
		new webpack.HotModuleReplacementPlugin(),
		new HtmlWebpackPlugin({
			filename: 'index.html',
			template: 'index.html',
			inject: true
		})
	]
})
