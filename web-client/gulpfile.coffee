watchify = require 'watchify'
browserify = require 'browserify'
gulp = require 'gulp'
glob = require 'glob'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
gutil = require 'gulp-util'
concat = require 'gulp-concat'
stylus = require 'gulp-stylus'
gzip = require 'gulp-gzip'
uglify = require 'gulp-uglify'
sourcemaps = require 'gulp-sourcemaps'
assign = require 'lodash.assign'
autoReload = require 'gulp-auto-reload'

autoreloadInject = ->
	gutil.noop()

createBundler = (development = false) ->
	files = ['app/initialize.coffee']

	opts = assign {}, watchify.args,
		entries: files
		extensions: ['.coffee', '.jade']
		paths: ['./node_modules', './app']
		debug: true # Enables sourcemap creation. We always want those.

	if development
		bundler = watchify browserify opts
	else
		bundler = browserify opts

	bundler.transform require 'coffeeify'
	bundler.transform require 'jadeify'

	return bundler

gulp.task 'watchSources', ->
	bundler = createBundler true

	bundle = ->
		bundler.bundle()
			.on('error', (err) ->	gutil.log gutil.colors.red('BrowserifyError'), err.message)
			.pipe(source 'app.js')
			.pipe(buffer())
			.pipe(sourcemaps.init({loadMaps: true}))
			.pipe(sourcemaps.write('./'))
			.pipe(gulp.dest('./public/js'))
			.pipe(gzip(gzipOptions: {level: 4})) # So fast there's no reason to skip this for development
			.pipe(gulp.dest('./public/js'))
			.on('end', -> reloader.onChange path: 'app.js')

	bundler.on 'update', bundle
	bundler.on 'log', gutil.log

	gulp.watch './app/views/styles/**/*.styl', ->
		styles().on('end', -> reloader.onChange path: 'app.css')

	reloader = autoReload()
	reloader.script().pipe(gulp.dest('./public'))
	autoreloadInject = reloader.inject

	bundle()
	styles()

gulp.task 'buildSources', ->
	bundler = createBundler()

	bundler.bundle()
		.on('error', (err) -> gutil.log gutil.colors.red('BrowserifyError'), err.message)
		.pipe(source 'app.js')
		.pipe(buffer())
		.pipe(sourcemaps.init({loadMaps: true}))
			.pipe(uglify())
		.pipe(sourcemaps.write('./'))
		.pipe(gulp.dest('./public/js'))
		.pipe(gzip(gzipOptions: {level: 9}))
		.pipe(gulp.dest('./public/js'))

styles = ->
	gulp.src('./app/views/styles/[^_]*.styl')
		.pipe(stylus(
				use: [require('axis')(), require('jeet')(), require('rupture')(), require('nib')()]
			))
		.pipe(concat('app.css'))
		.pipe(gulp.dest('./public/css'))

gulp.task 'styles', ->
	styles()
		.pipe(gzip())
		.pipe(gulp.dest('./public/css'))


gulp.task 'font-awesome-css', ->
	gulp.src('./node_modules/font-awesome/css/font-awesome.min.css')
		.pipe(gulp.dest('./public/css'))
		.pipe(gzip())
		.pipe(gulp.dest('./public/css'))

gulp.task 'font-awesome-fonts', ->
	gulp.src('./node_modules/font-awesome/fonts/*').pipe(gulp.dest('./public/fonts'))

gulp.task 'assets', ->
	gulp.src('./app/assets/**/*')
		.pipe(autoreloadInject('/'))
		.pipe(gulp.dest('./public'))

# 'Watch' is hardcoded to do a development build, 'build' uses production settings.
gulp.task 'watch', ['watchSources', 'fonts', 'assets']
gulp.task 'build', ['buildSources', 'styles', 'fonts', 'assets']

gulp.task 'fonts', ['font-awesome-css', 'font-awesome-fonts']
