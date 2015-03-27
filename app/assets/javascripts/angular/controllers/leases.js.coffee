app.controller "PropertyLeasesController", ["$scope", "$stateParams", "Property",
  ($scope, $stateParams, Property) ->
    $scope.record = {}

    $scope.init = ->
      $scope.getProperty($stateParams.property_id)

    $scope.getProperty = (id) ->
      Property.get({id: id}, (record) ->
        $scope.record.property = record
      )

    $scope.init()
]

app.controller "PropertyLeasesIndexController", ["$scope", "$stateParams",
  ($scope, $stateParams) ->
]

app.controller "PropertyLeaseFormController", ["$scope", "$stateParams",
  ($scope, $stateParams) ->
]

app.controller "PropertyLeasesShowController", ["$scope", "$stateParams",
  ($scope, $stateParams) ->
]
