app.controller "DefaultController", ["$scope", "$stateParams", "Me",
  ($scope, $stateParams, Me) ->
    $scope.me = {}

    $scope.getMe = ->
      Me.get((record) ->
        $scope.me = record
      )

    $scope.getMe()
]
