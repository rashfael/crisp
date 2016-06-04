{spawn, exec} = require 'child_process'

task 'install', 'Install dependencies', ->
	spawn 'npm', ['install'], {cwd: 'web-client', stdio: 'inherit'}
	spawn 'npm', ['install'], {cwd: 'server', stdio: 'inherit'}

task 'update', 'Update dependencies', ->
	spawn 'npm', ['update'], {cwd: 'web-client', stdio: 'inherit'}
	spawn 'npm', ['update'], {cwd: 'server', stdio: 'inherit'}

task 'watch', 'Launch application (development mode)', ->
	client = spawn 'npm', ['start'], {cwd: 'web-client', stdio: 'inherit' }
	server = null
	# client.stdout.on 'data', (data) ->
	# Delay start of server to prevent annoying auto-reloads.
	# unless server?
	server = spawn 'nodemon', ['--harmony', '--watch', 'app', '--ext', 'js,coffee', 'bin/server.js'], {cwd: 'server', stdio: 'inherit'}
	# process.stdout.write data
