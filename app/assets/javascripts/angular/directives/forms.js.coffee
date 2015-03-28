# app.directive 'formText', [
#     ->
#     {
#       restrict: "AC"
#       templateUrl: "shared/forms/text.html"
#       scope: true
#       replace: true
#       # link: (scope, element, attrs) ->
#       #   scope.field = attrs.field
#       #   scope.label = attrs.label
#     }
# ]


app.directive "formText", [
  ->
    {
      restrict: "AC"
      templateUrl: "shared/forms/text.html"
      scope: true
      replace: true
      link: (scope, element, attrs) ->
        scope.field = scope.record.object[attrs.field]
        scope.label = attrs.label
        scope.fieldName = attrs.field
    }
]
