app.controller "PropertyLeasesController", ["$scope", "$stateParams", "Property",
  ($scope, $stateParams, Property) ->
]

app.controller "PropertyLeaseController", ["$scope", "$stateParams", "Lease",
  ($scope, $stateParams, Lease) ->

    $scope.getLease = ->
      if $stateParams.lease_id
        Lease.get({property_id: $stateParams.id, id: $stateParams.lease_id}).then((record) ->
          $scope.record.lease = record
        )
      else
        $scope.record.lease = new Lease()

    $scope.getLease();
]

app.controller "PropertyLeasesIndexController", ["$scope", "$stateParams", "Lease",
  ($scope, $stateParams, Lease) ->

    $scope.$watch('record.object', ->
      if $scope.record.object && $scope.record.object.id
        $scope.refreshRecords()
    )

    $scope.refreshRecords = ->
      Lease.query({}, {property_id: $scope.record.object.id}).then((records)->
        $scope.records = records
      )
]

app.controller "PropertyLeaseFormController", ["$scope", "$stateParams", "Lease", "FormValidator", "$state",
  ($scope, $stateParams, Lease, FormValidator, $state) ->
    # $scope.$watch('record.object', ->
    #   if $scope.record.object
    #     $scope.init();
    # )

    $scope.init = ->
      if $stateParams.lease_id
        Lease.get({property_id: $scope.record.object.id, id: $stateParams.lease_id}).then((record) ->
          $scope.record.lease = record
        )
      else
        $scope.record.lease = new Lease()

    $scope.save = ->
      $scope.validator = new FormValidator($scope.form, $scope.record.lease);
      $scope.validator.resetValidations();

      if($scope.record.lease.id)
        promise = $scope.record.lease.update()
      else
        $scope.record.lease.property_id = $scope.record.object.id
        promise = $scope.record.lease.create()

      promise.then(((record) ->
        $state.go('default.properties.property.leases.index', {property_id: $scope.record.object.id});
      ), $scope.validator.failure)
]

app.controller "PropertyLeasesShowController", ["$scope", "$stateParams",
  ($scope, $stateParams) ->
]
