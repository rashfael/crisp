$ = require 'jquery'

# fix up backbone with jquery
Backbone = require 'backbone'
Backbone.$ = $

Application = require 'application'
routes = require 'routes'



# Initialize the application on DOM ready event.
$ ->
  new Application {
    title: 'crisp',
    controllerSuffix: '-controller',
    routes
  }
