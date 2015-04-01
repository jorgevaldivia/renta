# Initialize date picker elements when they are rendered.
app.directive 'datepicker', [
  ->
    {
      restrict: "AC"
      link: (scope, element, attrs) ->
        element.datepicker({format: 'yyyy-mm-dd'})
    }
]
