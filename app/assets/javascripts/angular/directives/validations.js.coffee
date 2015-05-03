# A factory and directive for handling server side validation. Basically, when
# a save fails due to server validation, the directive will make that visible
# to the user by highlighting the field and displaying the error messages sent
# by the server.
# 
# In order to use, you will need to setup a FormValidator instance and add the
# server-validation attribute to any field that works with server validation.
# 
# Ex:
#   validator = new FormValidator(myForm, myObj);
# 
#   saveObj = function(){
#     $scope.validator.resetValidations();
#     stop = new Stop($scope.newStop).create().then(function(){ successFunction }, validator.failure);
#   }
# 
# <input type='text' name='email' server-validation />
app.factory('FormValidator', [
  '$http'
  ($http) ->
    (form, obj) ->
      @form = form
      @obj = obj

      # A generic failure function that displays the error messages and
      # highlights the field in red.
      @failure = (response) ->
        angular.forEach response.data.errors, (errors, key) ->
          angular.forEach errors, (e) ->
            # console.log(key)
            # console.log(form[key])
            if form[key]
              form[key].$dirty = true
              form[key].$setValidity e, false
            return
          return
        return

      # Reset the validations by removing the highlighting and the error messages.

      @resetValidations = ->
        `var form`
        form = @form
        angular.forEach @obj, (value, key) ->
          if form[key]
            angular.forEach form[key].$error, (err_key, value) ->
              form[key].$setValidity value, true
              return
          return
        return

      return
])

.directive 'highlightIfError', [
  ->
    {
      restrict: "AC"
      link: (scope, element, attrs) ->
        fields = attrs.highlightIfError.split(",").map((field) ->
          "formScope.form['#{field.trim()}'].$invalid"
        )

        scope.$watchGroup(fields, (values) ->
          if values.indexOf(true) >= 0
            element.addClass("has-error")
          else
            element.removeClass("has-error")
        )
    }
]

.directive "errorMessages", [
  ->
    {
      restrict: "AC"
      templateUrl: 'shared/inline-errors.html'
      replace: true
      scope: true
      link: (scope, element, attrs) ->
        scope.field = attrs.errorMessages
    }
]
