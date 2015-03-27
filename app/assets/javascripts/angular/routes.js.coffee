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
      templateUrl: 'properties/layout.html'
      controller: "PropertiesController"
    )

    .state('default.properties.index',
      url: '/properties'
      templateUrl: 'properties/index.html'
      controller: "PropertiesController"
    )

    .state('default.properties.new',
      url: '/new'
      templateUrl: 'properties/new.html'
      controller: "PropertyFormController"
    )

    .state('default.properties.show',
      url: '/show/:id'
      templateUrl: 'properties/show.html'
      controller: "PropertyShowController"
    )
]
