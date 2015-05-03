@app.controller "LeasesFormCtrl", ["$scope", "Contact", "$timeout", 
  ($scope, Contact, $timeout) ->
    $scope.contacts = []
    $scope.form = {selectedContacts: []}

    $scope.init = (obj) ->
      if obj.tenant_ids && obj.tenant_ids.length  > 0
        $scope.initSelectedTenants(obj.tenant_ids);
    
    $scope.initSelectedTenants = (ids) ->
      Contact.query({"q[id_in][]": ids}, (results) ->
        $scope.contacts = results.records
        $scope.form.selectedContacts = results.records
      )

    $scope.refreshContacts = (search) ->
      params =
        "q[name_cont]": search
        "q[id_not_in][]": $scope.selectedContactIds()

      Contact.query(params, (results) ->
        $scope.contacts = results.records
      )

    $scope.selectedContactIds = ->
      selectedIds = []
      if $scope.form.selectedContacts
        selectedIds = $scope.form.selectedContacts.map (contact) ->
          contact.id

      selectedIds
]
