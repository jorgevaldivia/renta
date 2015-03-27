app.controller "PropertyLeasesController", ["$scope", "$stateParams",
  ($scope, $stateParams) ->

    $scope.init = ->
      $scope.getProperty($stateParams.property_id)

    $scope.init()
]

app.controller "PropertyLeasesIndexController", ["$scope", "$stateParams",
  ($scope, $stateParams) ->
]
