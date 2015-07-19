app.controller "InvoicesController", ["$scope", "$state", "$stateParams", "Invoice",
  ($scope, $state, $stateParams, Invoice) ->
]

app.controller "InvoiceController", ["$scope", "$state", "$stateParams", "Invoice",
  ($scope, $state, $stateParams, Invoice) ->
    $scope.record = {object: {}}

    $scope.getInvoice = (id) ->
      if id
        if(String($scope.record.object.id) != String(id))
          Invoice.get({id: id}).then((record) ->
            $scope.record.object = record
          )
      else
        $scope.record = new Invoice()

    $scope.delete = ->
      $scope.record.object.$delete({id: $scope.record.object.id}).then(->
        $state.go("default.invoices.index")
      )

    $scope.getInvoice($stateParams.id);
]

app.controller "InvoicesIndexController", ["$scope", "Invoice",
  ($scope, Invoice) ->
    $scope.refreshInvoices = ->
      Invoice.query((records)->
        $scope.records = records
      )

    $scope.refreshInvoices();
]

app.controller "InvoiceFormController", ["$scope", "$state", "$stateParams", "Invoice", "FormValidator",
  ($scope, $state, $stateParams, Invoice, FormValidator) ->
    $scope.formScope = {};

    $scope.init = ->
      if $stateParams.id
        $scope.getInvoice($stateParams.id)
      else
        $scope.record = {object: new Invoice()}

    $scope.save = ->
      $scope.validator = new FormValidator($scope.formScope.form, $scope.record.object)
      $scope.validator.resetValidations()
      if($scope.record.object.id)
        promise = $scope.record.object.$update({id: $scope.record.object.id})
      else
        promise = $scope.record.object.$save()

      promise.then(((record) ->
         $state.go('default.invoices.invoice.show', {id: record.id});
      ), $scope.validator.failure)

    $scope.init();
]

app.controller "InvoiceShowController", ["$scope", "$stateParams", "Invoice",
  ($scope, $stateParams, Invoice) ->

    $scope.tenantNames = ->
      return if !$scope.record.object.tenants

      names = $scope.record.object.tenants.map (tenant) ->
        tenant.name

      names.join(", ")

]
