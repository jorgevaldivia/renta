app.controller "PropertiesController", ["$scope", "$state", "$stateParams", "Property",
  ($scope, $state, $stateParams, Property) ->
]

app.controller "PropertyController", ["$scope", "$state", "$stateParams", "Property",
  ($scope, $state, $stateParams, Property) ->
    $scope.record = {object: {}}

    $scope.getProperty = (id) ->
      if id
        if(String($scope.record.object.id) != String(id))
          Property.get({id: id}).then((record) ->
            $scope.record.object = record
          )
      else
        $scope.record = new Property()

    $scope.delete = ->
      $scope.record.object.$delete({id: $scope.record.object.id}).then(->
        $state.go("default.properties.index")
      )

    $scope.getProperty($stateParams.id);
]

app.controller "PropertiesIndexController", ["$scope", "Property",
  ($scope, Property) ->
    $scope.refreshProperties = ->
      Property.query().then((records)->
        $scope.records = records
      )

    $scope.refreshProperties();
]

app.controller "PropertyFormController", ["$scope", "$state", "$stateParams", "Property", "FormValidator",
  ($scope, $state, $stateParams, Property, FormValidator) ->
    $scope.formScope = {};

    $scope.init = ->
      if $stateParams.id
        $scope.getProperty($stateParams.id)
      else
        $scope.record = {object: new Property()}

    $scope.saveSuccess = (result) ->
      $state.go('default.properties.property.show', {id: result.id});

    $scope.init();
]

app.controller "PropertyShowController", ["$scope", "$stateParams", "Property",
  ($scope, $stateParams, Property) ->

    $scope.otherTenantNames = ->
      return if !$scope.record.object.current_lease

      num_tenants = $scope.record.object.current_lease.leases_users.length - 1
      names = []

      if num_tenants > 0
        names = $scope.record.object.current_lease.leases_users.slice(-num_tenants).map (tenant) ->
          tenant.contact.name

      names.join(", ")
]
