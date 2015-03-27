#= require angular
#= require angular-resource
#= require angular-sanitize
#= require angular-rails-templates
#= require ./angular-ui-router.min
#= require_self
#= require ./angular-animate.min
#= require ./routes
#= require_tree ./services
#= require_tree ./directives
#= require_tree ./controllers
#= require_tree ../templates

# Init Angular app
@app = angular.module("propertea", ["ngResource", "ui.router", "ui.select",
  "ngSanitize", "templates", "ngAnimate", "truncate"])

# Rails 4 now requires the use of the csrf token on all requests, including
# ajax ones. This gets the token from the dom (added by rails) and adds it as a
# header on angluar http requests.
@app.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]

@app.run ['$rootScope', '$state', '$stateParams',
  ($rootScope, $state, $stateParams) ->
    $rootScope.$state = $state
    $rootScope.$stateParams = $stateParams
]

@app.controller 'coreSettingsCtrl', [
  '$scope', '$rootScope', '$window', '$timeout', 'viewport'
  ($scope, $rootScope, $window, $timeout, viewport) ->

    $scope.core =
      name: 'Propertea'
      version: '0.0.1'
      settings:
        fullScreen: false
        pageLoading: false
        headerFixed: true
        headerSearchForm: false
        sidebarLeftOpen: false
        sidebarLeftFixed: false
        sidebarLeftCollapse: if viewport.width() >= 768 and viewport.width() < 992 then true else false
      screen:
        xs: if viewport.width() < 768 then true else false
        sm: if viewport.width() >= 768 and viewport.width() < 992 then true else false
        md: if viewport.width() >= 992 and viewport.width() < 1200 then true else false
        lg: if viewport.width() >= 1200 then true else false
        height: viewport.height()
        width: viewport.width()

    ###* hide sidebar and show loading indicator ###

    $rootScope.$on '$stateChangeStart', ->
      $scope.core.settings.sidebarLeftOpen = false
      $scope.core.settings.pageLoading = true
      return

    ###* show loading indicator ###

    $rootScope.$on '$stateChangeSuccess', ->
      $scope.core.settings.pageLoading = false
      # Scroll to top
      $("html, body").animate({ scrollTop: 0 }, 0);
      return

    ###* On resize, update viewport variable ###

    angular.element($window).on 'resize', ->
      $timeout.cancel $scope.resizing
      $scope.resizing = $timeout((->
        $scope.core.screen.xs = if viewport.width() < 768 then true else false
        $scope.core.screen.sm = if viewport.width() >= 768 and viewport.width() < 992 then true else false
        $scope.core.screen.md = if viewport.width() >= 992 and viewport.width() < 1200 then true else false
        $scope.core.screen.lg = if viewport.width() >= 1200 then true else false
        $scope.core.screen.height = viewport.height()
        $scope.core.screen.width = viewport.width()
        return
      ), 100)
      return
    return
]

@app.factory 'viewport', [
  '$window'
  ($window) ->
    {
      height: ->
        window.innerHeight or document.documentElement.clientHeight or document.body.clientHeight
      width: ->
        window.innerWidth or document.documentElement.clientWidth or document.body.clientWidth
    }
]

@app.directive 'indicator', [
  '$rootScope', '$timeout'
  ($rootScope, $timeout) ->
    {
      restrict: 'A'
      replace: true
      templateUrl: 'partials/spinner.html'
      link: ($scope, iElm, iAttrs) ->
        $timeout ->
          $wrapper = angular.element(iElm).parent('.spinner-wrapper')
          $spinner = angular.element(iElm)

          $rootScope.$on '$stateChangeStart', ->
            $wrapper.addClass 'show'

          $rootScope.$on '$stateChangeSuccess', ->
            $wrapper.removeClass 'show'

    }
]
