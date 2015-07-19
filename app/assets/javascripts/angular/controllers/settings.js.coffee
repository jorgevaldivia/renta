app.controller "SettingsController", ["$scope", "$stateParams",
  ($scope, $stateParams) ->
]

app.controller "SettingsIndexController", ["$scope", "$stateParams",
  ($scope, $stateParams) ->
]

app.controller "SettingsProfileController", ["$scope", "$stateParams", "FormValidator", "$state"
  ($scope, $stateParams, FormValidator, $state) ->
    $scope.formScope = {}

    $scope.init = ->

    $scope.save = ->
      $scope.validator = new FormValidator($scope.formScope.form, $scope.records.me);
      $scope.validator.resetValidations();

      promise = $scope.records.me.update()

      promise.then(((record) ->
        $state.go('default.dashboard', {}, {reload: true});
      ), $scope.validator.failure)

]
