app.directive 'contenteditable', ->
  {
    restrict: 'A'
    require: 'ngModel'
    link: (scope, element, attrs, ngModel) ->

      read = ->
        ngModel.$setViewValue element.html()

      ngModel.$render = ->
        element.html ngModel.$viewValue or ''

      element.bind 'blur keyup change', ->
        scope.$apply read
  }
