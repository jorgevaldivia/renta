app.controller "PropertiesController", ["$scope", "Property",
  ($scope, Property) ->

    $scope.refreshProperties = ->
      Property.query((records)->
        $scope.records = records
      )

    $scope.refreshProperties();
]


app.controller "PropertyFormController", ["$scope", "Property",
  ($scope, Property) ->

    $scope.refreshProperties = ->
      Property.query((records)->
        $scope.records = records
      )

    $scope.refreshProperties();
]

app.controller "PropertyShowController", ["$scope", "$stateParams", "Property",
  ($scope, $stateParams, Property) ->

    $scope.getProperty = ->
      Property.get({id: $stateParams.id}, (record) ->
        $scope.record = record
      )

    $scope.getProperty();
]