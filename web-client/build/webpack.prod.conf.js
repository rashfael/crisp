var path = require('path')
var webpack = require('webpack')
var merge = require('webpack-merge')
var utils = require('./utils')
var path = require('path')
var projectRoot = path.resolve(__dirname, '../')
var baseWebpackConfig = require('./webpack.base.conf')
var ExtractTextPlugin = require('extract-text-webpack-plugin')
var HtmlWebpackPlugin = require('html-webpack-plugin')
var CompressionWebpackPlugin = require('compression-webpack-plugin')
var CleanWebpackPlugin = require('clean-webpack-plugin')
const MiniCssExtractPlugin = require("mini-css-extract-plugin")
const UglifyPlugin = require('uglifyjs-webpack-plugin')

var webpackConfig = merge(baseWebpackConfig, {
	mode: 'production',
	devtool: 'source-map',
	resolve: {
		alias: {
			'config': path.resolve(projectRoot, 'config.prod.js'),
		}
	},
	module: {
		rules: [
			{ test: /\.vue$/, use: [{
				loader:'vue-loader',
			}]},
			{ test: /\.css$/, use: [
				MiniCssExtractPlugin.loader,
				"css-loader"
			]},
			{ test: /\.styl|\.stylus$/, use: [
				MiniCssExtractPlugin.loader,
				'css-loader',
				{
					loader: 'stylus-loader',
					options: {
						use: [require('rupture')(), require('buntpapier/stylus')()],
					},
				},
			]}
		]
	},
	output: {
		filename: utils.assetsPath('js/[name].[chunkhash].js'),
		chunkFilename: utils.assetsPath('js/[id].[chunkhash].js'),
		sourceMapFilename: '[file].map.js',
	},
	optimization: {
		runtimeChunk: true,
		splitChunks: {
			chunks: 'all',
			cacheGroups: {
				commons: {
					test: /[\\/]node_modules[\\/]/,
					name: "vendors",
					chunks: "all"
				}
			}
		},
		minimizer: [
			new UglifyPlugin({
				uglifyOptions: {
					compress: {
						// turn off flags with small gains to speed up minification
						arrows: false,
						collapse_vars: false, // 0.3kb
						comparisons: false,
						computed_props: false,
						hoist_funs: false,
						hoist_props: false,
						hoist_vars: false,
						inline: false,
						loops: false,
						negate_iife: false,
						properties: false,
						reduce_funcs: false,
						reduce_vars: false,
						switches: false,
						toplevel: false,
						typeofs: false,

						// a few flags with noticable gains/speed ratio
						// numbers based on out of the box vendor bundle
						booleans: true, // 0.7kb
						if_return: true, // 0.4kb
						sequences: true, // 0.7kb
						unused: true, // 2.3kb

						// required features to drop conditional branches
						conditionals: true,
						dead_code: true,
						evaluate: true
					},
					mangle: {
						safari10: true
					}
				},
				sourceMap: true,
				cache: true,
				parallel: true
			})
		]
	},
	plugins: [
		new webpack.DefinePlugin({
			'ENV_DEVELOPMENT': false,
			'process.env': {
				NODE_ENV: '"production"'
			},
		}),
		// extract css into its own file
		new MiniCssExtractPlugin({
			filename: utils.assetsPath('css/[name].[chunkhash].css'),
			chunkFilename:  utils.assetsPath('css/[name].[chunkhash].css')
		}),
		// generate dist index.html with correct asset hash for caching.
		// you can customize output by editing /index.html
		// see https://github.com/ampedandwired/html-webpack-plugin
		new HtmlWebpackPlugin({
			template: 'index.html',
			inject: true,
			minify: {
				removeComments: true,
				collapseWhitespace: true,
				removeAttributeQuotes: true
				// more options:
				// https://github.com/kangax/html-minifier#options-quick-reference
			},
			// necessary to consistently work with multiple chunks via CommonsChunkPlugin
			chunksSortMode: 'dependency'
		}),
		new CompressionWebpackPlugin({
			asset: '[path].gz[query]',
			algorithm: 'gzip',
			test: new RegExp(
				'\\.(js|css)$'
			),
			threshold: 10240,
			minRatio: 0.8
		})
	]
})

module.exports = webpackConfig
