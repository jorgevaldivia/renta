app.controller("IndexResultsController", ["$scope",
  ($scope) ->

    $scope.records = []
    $scope.paging = {total_count: 0}
    $scope.pagingParams = {page: 1}
    $scope.q = {}

    $scope.init = ->
      $scope.getRecords();

    $scope.getRecords = ->
      $scope.records = []

      $scope.resource.query($scope.queryParams(), (paginatedResult) ->
        $scope.records = paginatedResult.records
        $scope.paging = paginatedResult.paging
      )

    $scope.queryParams = ->
      angular.extend({}, $scope.pagingParams, $scope.q)

    $scope.nextPage = ->
      if $scope.paging.next_page
        $scope.pagingParams.page = $scope.paging.next_page
        $scope.getRecords()

    $scope.previousPage = ->
      if $scope.paging.prev_page
        $scope.pagingParams.page = $scope.paging.prev_page
        $scope.getRecords()

    $scope.pagingFirstRecord = ->
      ((($scope.paging.max_per_page * $scope.paging.current_page) -
        $scope.paging.max_per_page) + 1) || 0

    $scope.pagingLastRecord = ->
      (Math.min(($scope.pagingFirstRecord() + $scope.paging.count) - 1,
        $scope.paging.total_count)) || 0

    $scope.addSearchParam = (searchParam) ->
      $scope.q = angular.extend({}, $scope.q, searchParam)
      # Always want to set the page to 1 when a search value is altered.
      $scope.pagingParams.page = 1
      $scope.getRecords()
])

app.directive "indexResults", ["$compile", "$injector"
  ($compile, $injector) ->
    restrict: "CE"
    controller: "IndexResultsController"
    link: (scope, elem, attrs, controller) ->
      scope.resource = scope.base64 = $injector.get(attrs.resource);
      scope.init();
]

app.directive "indexResultsRefresh", ->
  restrict: "CE"
  replace: true
  template: "<button class='btn' type='button' ng-click='getRecords()'><i class='fa fa-repeat'></i></button>"
  link: (scope, elem, attrs) ->
