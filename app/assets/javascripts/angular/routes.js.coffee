app.config [
  "$stateProvider", "$urlRouterProvider",
  ($stateProvider, $urlRouterProvider) ->

    $urlRouterProvider.otherwise 'dashboard'

    $stateProvider.state('default',
      abstract: true
      url: ''
      templateUrl: 'layouts/default.html'
    )

    .state('default.dashboard',
      url: '/dashboard'
      templateUrl: 'dashboards/show.html'
      controller: "DashboardController"
    )

    .state('default.properties',
      url: '/properties'
      templateUrl: 'properties/index.html'
      controller: "PropertiesController"
    )


    # $urlRouterProvider.otherwise '/dashboard'

    # $stateProvider.
    #   state('dashboard',
    #     url: '/dashboard'
    #     templateUrl: 'dashboards/show.html'
    #     controller: "DashboardController"
    #   )

    #   .state('properties',
    #     url: '/properties'
    #     templateUrl: 'properties/index.html'
    #     controller: "PropertiesController"
    #   )
]
