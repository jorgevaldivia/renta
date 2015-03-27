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
      url: '/'
      templateUrl: 'properties/index.html'
      controller: "PropertiesIndexController"
    )

    .state('default.properties.new',
      url: '/new'
      templateUrl: 'properties/form.html'
      controller: "PropertyFormController"
    )

    .state('default.properties.edit',
      url: '/:id/edit'
      templateUrl: 'properties/form.html'
      controller: "PropertyFormController"
    )

    .state('default.properties.show',
      url: '/:id'
      templateUrl: 'properties/show.html'
      controller: "PropertyShowController"
    )
]
