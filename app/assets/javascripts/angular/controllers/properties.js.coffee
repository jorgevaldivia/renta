app.controller "PropertiesController", ["$scope", "$state", "$stateParams", "Property",
  ($scope, $state, $stateParams, Property) ->
    $scope.record = {object: {}}

    $scope.delete = ->
      $scope.record.object.$delete({id: $scope.record.object.id}).then(->
        $state.go("default.properties.index")
      )
]

app.controller "PropertiesIndexController", ["$scope", "Property",
  ($scope, Property) ->
    $scope.refreshProperties = ->
      Property.query((records)->
        $scope.records = records
      )

    $scope.record.object = new Property()
    $scope.refreshProperties();
]

app.controller "PropertyFormController", ["$scope", "$state", "$stateParams", "Property", "FormValidator",
  ($scope, $state, $stateParams, Property, FormValidator) ->

    $scope.init = ->
      if $stateParams.id
        Property.get({id: $stateParams.id}, (record) ->
          $scope.record.object = record
        )
      else
        $scope.record.object = new Property()

    $scope.save = ->
      $scope.validator = new FormValidator($scope.propertyForm, $scope.record.object);
      $scope.validator.resetValidations();
      if($scope.record.object.id)
        promise = $scope.record.object.$update({id: $scope.record.object.id})
      else
        promise = $scope.record.object.$save()

      promise.then(((record) ->
         $state.go('default.properties.show', {id: record.id});
      ), $scope.validator.failure)

    $scope.init();
]

app.controller "PropertyShowController", ["$scope", "$stateParams", "Property",
  ($scope, $stateParams, Property) ->
    
    $scope.getProperty = ->
      if $stateParams.id
        Property.get({id: $stateParams.id}, (record) ->
          $scope.record.object = record
        )
      else
        $scope.record = new Property()

    $scope.getProperty();
]
