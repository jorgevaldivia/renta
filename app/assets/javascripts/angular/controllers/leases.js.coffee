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

app.controller "PropertyLeaseFormController", ["$scope", "$stateParams", "Lease", "FormValidator", "$state",
  ($scope, $stateParams, Lease, FormValidator, $state) ->

    $scope.init = ->
      if $stateParams.id
        Lease.get({property_id: $scope.record.property.id, id: $stateParams.id}, (record) ->
          $scope.record.object = record
        )
      else
        $scope.record.object = new Lease()

    $scope.save = ->
      $scope.validator = new FormValidator($scope.form, $scope.record.object);
      $scope.validator.resetValidations();

      if($scope.record.object.id)
        promise = $scope.record.object.update()
      else
        $scope.record.object.property_id = $scope.record.property.id
        promise = $scope.record.object.create()

      promise.then(((record) ->
        $state.go('default.leases.index', {property_id: $scope.record.property.id});
      ), $scope.validator.failure)

    $scope.init();
]

app.controller "PropertyLeasesShowController", ["$scope", "$stateParams",
  ($scope, $stateParams) ->
]
