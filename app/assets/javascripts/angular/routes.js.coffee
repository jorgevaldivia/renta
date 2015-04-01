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

    .state('default.properties.property.leases',
      url: '/leases'
      template: '<div class="ui-view slide-right"></div>'
      controller: "PropertyLeasesController"
      ncyBreadcrumb: { skip: true }
    )

    .state('default.properties.property.leases.index',
      url: '/'
      templateUrl: 'properties/leases/index.html'
      controller: "PropertyLeasesIndexController"
      ncyBreadcrumb: {
        parent: 'default.properties.property'
        label: "Leases"
      }
    )

    .state('default.properties.property.leases.new',
      url: '/new'
      templateUrl: 'properties/leases/form.html'
      controller: "PropertyLeaseFormController"
      ncyBreadcrumb: {
        parent: 'default.properties.property.leases.index'
        label: "New"
      }
    )

    .state('default.properties.property.leases.lease',
      url: '/:lease_id'
      template: '<div class="ui-view slide-right"></div>'
      controller: "PropertyLeaseController"
      ncyBreadcrumb: {
        parent: 'default.properties.property.leases.index'
        label: "{{record.lease.start_date}}"
      }
    )

    .state('default.properties.property.leases.lease.edit',
      url: '/edit'
      templateUrl: 'properties/leases/form.html'
      controller: "PropertyLeaseFormController"
      ncyBreadcrumb: {
        label: "Edit"
      }
    )

    .state('default.properties.property.invoices',
      url: '/invoices'
      template: '<div class="ui-view slide-right"></div>'
      controller: "PropertyInvoicesController"
      ncyBreadcrumb: { skip: true }
    )

    .state('default.properties.property.invoices.index',
      url: '/'
      templateUrl: 'properties/invoices/index.html'
      controller: "PropertyInvoicesIndexController"
      ncyBreadcrumb: {
        parent: 'default.properties.property'
        label: "Invoices"
      }
    )

    .state('default.properties.property.invoices.new',
      url: '/new'
      templateUrl: 'properties/invoices/form.html'
      controller: "PropertyInvoiceFormController"
      ncyBreadcrumb: {
        parent: 'default.properties.property.invoices.index'
        label: "New"
      }
    )

    .state('default.properties.property.invoices.invoice',
      url: '/:invoice_id'
      template: '<div class="ui-view slide-right"></div>'
      controller: "PropertyInvoiceController"
      ncyBreadcrumb: {
        parent: 'default.properties.property.invoices.index'
        label: "{{record.invoice.start_date}}"
      }
    )

    .state('default.properties.property.invoices.invoice.edit',
      url: '/edit'
      templateUrl: 'properties/invoices/form.html'
      controller: "PropertyInvoiceFormController"
      ncyBreadcrumb: {
        label: "Edit"
      }
    )

    # .state('default.leases',
    #   url: '/properties/:property_id/leases'
    #   abstract: true
    #   templateUrl: 'properties/leases/layout.html'
    #   controller: "PropertyLeasesController"
    # )

    # .state('default.leases.new',
    #   url: '/new'
    #   templateUrl: 'properties/leases/form.html'
    #   controller: "PropertyLeaseFormController"
    # )

    # .state('default.leases.edit',
    #   url: '/:id/edit'
    #   templateUrl: 'properties/leases/form.html'
    #   controller: "PropertyLeaseFormController"
    # )

    # .state('default.leases.show',
    #   url: '/:id'
    #   templateUrl: 'properties/leases/show.html'
    #   controller: "PropertyLeaseShowController"
    # )
]
