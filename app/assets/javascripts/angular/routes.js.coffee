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

    $stateProvider.state('default.settings',
      url: '/settings'
      templateUrl: 'settings/layout.html'
      controller: "SettingsController"
      ncyBreadcrumb: { label: "Settings" }
    )

    $stateProvider.state('default.settings.profile',
      url: '/profile/edit'
      templateUrl: 'settings/profile/edit.html'
      controller: "SettingsProfileController"
      ncyBreadcrumb: { label: "Profile" }
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
      templateUrl: 'properties/new.html'
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

    .state('default.contacts',
      url: '/contacts'
      template: '<div class="ui-view slide-down"></div>'
      controller: "ContactsController"
      ncyBreadcrumb: { skip: true }
    )

    .state('default.contacts.index',
      url: '/'
      templateUrl: 'contacts/index.html'
      controller: "ContactsIndexController"
      ncyBreadcrumb: { label: 'Contacts' }
    )

    .state('default.contacts.new',
      url: '/new'
      templateUrl: 'contacts/new.html'
      controller: "ContactFormController"
      ncyBreadcrumb: {
        parent: 'default.contacts.index'
        label: "New"
      }
    )

    .state('default.contacts.contact',
      url: '/:id'
      templateUrl: 'contacts/contact.html'
      controller: "ContactController"
      abstract: true
      ncyBreadcrumb: {
        parent: 'default.contacts.index'
        label: "{{ record.object.name | characters:25 }}"
        force: true
      }
    )

    .state('default.contacts.contact.show',
      url: ''
      templateUrl: 'contacts/show.html'
      controller: "ContactShowController"
      ncyBreadcrumb: { skip: true }
    )

    .state('default.contacts.contact.edit',
      url: '/edit'
      templateUrl: 'contacts/form.html'
      controller: "ContactFormController"
      ncyBreadcrumb: {
        parent: 'default.contacts.contact'
        label: "Edit"
      }
    )

    .state('default.invoices',
      url: '/invoices'
      template: '<div class="ui-view slide-down"></div>'
      controller: "InvoicesController"
      ncyBreadcrumb: { skip: true }
    )

    .state('default.invoices.index',
      url: '/'
      templateUrl: 'invoices/index.html'
      controller: "InvoicesIndexController"
      ncyBreadcrumb: { label: 'Invoices' }
    )

    .state('default.invoices.new',
      url: '/new'
      templateUrl: 'invoices/new.html'
      controller: "InvoiceFormController"
      ncyBreadcrumb: {
        parent: 'default.invoices.index'
        label: "New"
      }
    )

    .state('default.invoices.invoice',
      url: '/:id'
      template: '<div class="ui-view slide-down"></div>'
      controller: "InvoiceController"
      abstract: true
      ncyBreadcrumb: {
        parent: 'default.invoices.index'
        label: "{{ record.object.subject | characters:25 }}"
        force: true
      }
    )

    .state('default.invoices.invoice.show',
      url: ''
      templateUrl: 'invoices/show.html'
      controller: "InvoiceShowController"
      ncyBreadcrumb: { skip: true }
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
