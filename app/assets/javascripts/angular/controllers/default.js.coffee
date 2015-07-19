app.controller "DefaultController", ["$scope", "$stateParams", "Me",
  ($scope, $stateParams, Me) ->
    $scope.records = {}
    $scope.records.me = new Me()

    $scope.getMe = ->
      Me.get().then((record) ->
        $scope.records.me = record
      )

    $scope.getMe()
]
