app.config [
  '$routeProvider'
  ($routeProvider) ->
    $routeProvider.when '/dashboard',
      controller: 'DashboardController'
      templateUrl: 'dashboards/show.html'

    $routeProvider.when '/properties',
      controller: 'PropertiesController'
      templateUrl: 'properties/index.html'
    
    $routeProvider.otherwise({ redirectTo: "/dashboard" });

    return
]
