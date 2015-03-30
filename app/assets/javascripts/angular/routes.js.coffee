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
      ncyBreadcrumb: {
        label: 'Sweet Dash'
      }
    )

    .state('default.properties',
      url: '/properties'
      templateUrl: 'properties/layout.html'
      controller: "PropertiesController"
      ncyBreadcrumb: { skip: true }
    )

    .state('default.properties.index',
      url: '/'
      templateUrl: 'properties/index.html'
      controller: "PropertiesIndexController"
      ncyBreadcrumb: { label: 'Properties' }
    )

    .state('default.properties.new',
      url: '/new'
      templateUrl: 'properties/form.html'
      controller: "PropertyFormController"
      ncyBreadcrumb: {
        parent: 'default.properties.index'
        label: "New"
      }
    )

    .state('default.properties.property',
      url: '/:id'
      templateUrl: 'properties/property.html'
      controller: "PropertyController"
      abstract: true
      ncyBreadcrumb: {
        parent: 'default.properties.index'
        label: "{{ record.object.name | characters:25 }}"
        force: true
      }
    )

    .state('default.properties.property.show',
      url: ''
      templateUrl: 'properties/show.html'
      controller: "PropertyShowController"
      ncyBreadcrumb: { skip: true }
    )

    .state('default.properties.property.edit',
      url: '/edit'
      templateUrl: 'properties/form.html'
      controller: "PropertyFormController"
      ncyBreadcrumb: {
        parent: 'default.properties.property'
        label: "Edit"
      }
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
