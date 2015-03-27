app.config [
  "$stateProvider", "$urlRouterProvider",
  ($stateProvider, $urlRouterProvider) ->

    $urlRouterProvider.otherwise 'dashboard'

    $stateProvider.state('default',
      abstract: true
      url: ''
      controller: "DefaultController"
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

    .state('default.leases',
      url: '/properties/:property_id/leases'
      abstract: true
      templateUrl: 'properties/leases/layout.html'
      controller: "PropertyLeasesController"
    )

    .state('default.leases.index',
      url: '/'
      templateUrl: 'properties/leases/index.html'
      controller: "PropertyLeasesIndexController"
    )

    .state('default.leases.new',
      url: '/new'
      templateUrl: 'properties/leases/form.html'
      controller: "PropertyLeaseFormController"
    )

    .state('default.leases.edit',
      url: '/:id/edit'
      templateUrl: 'properties/leases/form.html'
      controller: "PropertyLeaseFormController"
    )

    .state('default.leases.show',
      url: '/:id'
      templateUrl: 'properties/leases/show.html'
      controller: "PropertyLeaseShowController"
    )
]
