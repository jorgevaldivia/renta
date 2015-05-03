# Initialize peity elements when they are rendered.
app.directive 'peity', [
  ->
    {
      restrict: "A"
      link: (scope, element, attrs) ->

        initPeity = (color) ->
          element.peity(attrs.peity, {
            fill: color,
            stroke: color
          })

        if attrs.watch
          scope.$watch(attrs.watch, (value) ->
            if value
              element.removeClass("text-danger").addClass("text-primary")
            else
              element.removeClass("text-primary").addClass("text-danger")

            initPeity(element.css("color"))
          )
        else
          initPeity(element.css("color"))
    }
]
