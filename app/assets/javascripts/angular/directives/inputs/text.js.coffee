# # Initialize date picker elements when they are rendered.
# app.directive 'formInput', [
#   ->
#     {
#       restrict: "AC"
#       # controller: ->
#       require: "form"
#       link: (scope, element, attrs, form) ->
#         console.log form
#         # console.log(attrs.ngSubmit);
#         # attrs.ngSubmit.call()
#     }
# ]

app.directive 'submitAndValidate', ["$parse", "FormValidator"
  ($parse, FormValidator) ->
    restrict: "AC"
    require: "form"
    scope: {
      record: "=ngRecord"
      success: "&ngSuccess"
    }
    link: (scope, element, attrs, form) ->
      validator = new FormValidator(form, scope.record)

      element.on('submit', (event) ->
        validator.resetValidations()
  
        scope.record.save().then(((result) ->
          scope.success({result: result})
        ), validator.failure)
      )
]


# Initialize date picker elements when they are rendered.
app.directive 'textInput', [
  ->
    {
      restrict: "AC"
      templateUrl: 'inputs/text.html'
      replace: true
      scope: {
        ngModel: '=',
        formScope: '&formScope',
      }
      require: ["^form"]
      link: (scope, element, attrs, controllers) ->
        scope.label = attrs.label
        scope.field_name = attrs.fieldName

        scope.form = controllers[0]
        # scope.ngModelCtrl = controllers[1]

        # console.log scope.ngModelCtrl
    }
]
