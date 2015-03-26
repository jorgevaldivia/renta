#= require angular
#= require angular-resource
#= require angular-sanitize
#= require angular-rails-templates
#= require angular-route
#= require_self
#= require ./routes
#= require_tree ./services
#= require_tree ./directives
#= require_tree ./controllers
#= require_tree ../templates

# Init Angular app
@app = angular.module("propertea", ["ngResource", "ngRoute", "ui.select", "ngSanitize", "templates"])

# Rails 4 now requires the use of the csrf token on all requests, including
# ajax ones. This gets the token from the dom (added by rails) and adds it as a
# header on angluar http requests.
@app.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]
