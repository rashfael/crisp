var path = require('path')
var webpack = require('webpack')
var stylusLoader = require('stylus-loader')
var utils = require('./utils')
var projectRoot = path.resolve(__dirname, '../')
const VueLoaderPlugin = require('vue-loader/lib/plugin')

module.exports = {
	entry: {
		app: './src/main.js'
	},
	output: {
		path: path.resolve(__dirname, '../dist'),
		publicPath: '/',
		filename: '[name].js',
		chunkFilename: '[name].[id].[hash].js'
	},
	resolve: {
		extensions: ['.js', '.json', '.vue'],
		modules: [path.resolve(__dirname, "../src"), path.resolve('src/styles'), path.join(__dirname, '../node_modules'), 'node_modules']
	},
	module: {
		rules: [
			{ test: /\.js$/, include: projectRoot, exclude: /node_modules\/(?!buntpapier|lodash-es)/, use: [{
				loader: 'babel-loader',
				options: {
					babelrc: false,
					presets: [
						['@babel/env', {
							modules: false,
							loose: true,
							targets: {
								chrome: 66
							}}],
						['@babel/stage-1', { "decoratorsLegacy": true }]
					],
					plugins: ['@babel/proposal-optional-chaining']
				}}]
			},
			{
        test: /\.jade$/,
        loader: 'pug-plain-loader'
      },
			{ test: /\.html$/, use: ['vue-html-loader'] },
			{test: /\.svg(\?.*)?/, use: [{
				loader: 'svg-url-loader',
				options: {
					noquotes: true,
					limit: 10000,
					name: utils.assetsPath('img/[name].[hash:7].[ext]')
				}
			}]},
			{ test: /\.(png|jpe?g|gif)(\?.*)?$/, use: [{
				loader: 'url-loader',
				options: {
					limit: 10000,
					name: utils.assetsPath('img/[name].[hash:7].[ext]')
				}
			}]},
			{ test: /\.(woff2?|eot|ttf|otf)(\?.*)?$/, use: [{
				loader: 'url-loader',
				options: {
					limit: 10000,
					name: utils.assetsPath('fonts/[name].[hash:7].[ext]')
				}
			}]}
		]
	},
	plugins: [
		new VueLoaderPlugin(),
	]
}
