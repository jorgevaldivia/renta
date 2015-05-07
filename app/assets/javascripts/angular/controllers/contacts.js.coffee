app.controller "ContactsController", ["$scope", "$state", "$stateParams", "Contact",
  ($scope, $state, $stateParams, Contact) ->
]

app.controller "ContactController", ["$scope", "$state", "$stateParams", "Contact",
  ($scope, $state, $stateParams, Contact) ->
    $scope.record = {object: {}}

    $scope.getContact = (id) ->
      if id
        if(String($scope.record.object.id) != String(id))
          Contact.get({id: id}, (record) ->
            $scope.record.object = record
          )
      else
        $scope.record = new Contact()

    $scope.delete = ->
      $scope.record.object.$delete({id: $scope.record.object.id}).then(->
        $state.go("default.contacts.index")
      )

    $scope.getContact($stateParams.id);
]

app.controller "ContactsIndexController", ["$scope", "Contact",
  ($scope, Contact) ->

    $scope.refreshContacts = ->
      Contact.query().then((records)->
        $scope.records = records
      )

    $scope.refreshContacts();
]
