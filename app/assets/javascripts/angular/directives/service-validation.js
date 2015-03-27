// A factory and directive for handling server side validation. Basically, when
// a save fails due to server validation, the directive will make that visible
// to the user by highlighting the field and displaying the error messages sent
// by the server.
// 
// In order to use, you will need to setup a FormValidator instance and add the
// server-validation attribute to any field that works with server validation.
// 
// Ex:
//   validator = new FormValidator(myForm, myObj);
// 
//   saveObj = function(){
//     $scope.validator.resetValidations();
//     stop = new Stop($scope.newStop).create().then(function(){ successFunction }, validator.failure);
//   }
// 
// <input type='text' name='email' server-validation />


app.factory("FormValidator", ["$http", function($http) {
  return function(form, obj) {

    this.form = form;
    this.obj = obj;

    // A generic failure function that displays the error messages and
    // highlights the field in red.
    this.failure = function(response){
      angular.forEach(response.data.errors, function(errors, key) {
        angular.forEach(errors, function(e) {
          form[key].$dirty = true;
          form[key].$setValidity(e, false);
        });
      });
    };

    // Reset the validations by removing the highlighting and the error messages.
    this.resetValidations = function(){
      var form = this.form;
      angular.forEach(this.obj, function(value, key) {
        if(form[key]){
          angular.forEach(form[key].$error, function(err_key, value) {
            form[key].$setValidity(value, true);
          });
        }
      });
    }
  };
}])

// The directive. As in the example above, simply add the 'server-validation'
// attr to any form field that uses server side validation. Any errors returned
// will be displayed under the field.
.directive('serverValidation', ["$compile", function($compile) {
  return {
    restrict: 'A',
    require: '?ngModel',
    link: function(scope, element, attrs, ctrl) {

      // Creates a wrapper for the error messages immediately after the form
      // field.
      createErrorContainer = function(attrs){
        var error_container = $("<p class='help-block text-danger fs-12 mb-0 error-help'></p>");
        error_container.attr("ng-show", "propertyForm." + attrs.name + 
          ".$invalid && propertyForm." + attrs.name + ".$dirty");
        $compile(error_container)(scope);
        element.after(error_container);
      };

      // Adds the errors returned from the server to the error container
      addErrors = function(element, ctrl){
        var error_container = element.next(".error-help");
        var errors = [];
        angular.forEach(ctrl.$error, function(value, key) { 
          if(ctrl.$error[key] == true)
            errors.push(key);
        });
        error_container.html(errors.join(", "));

        // Highlight the field in red
        element.parents(".form-group:first").addClass("has-error");
      };

      createErrorContainer(attrs);

      scope.$watch(function(){
        return ctrl.$invalid;
      }, function(newVal, oldVal){
        
        if(newVal == true){
          addErrors(element, ctrl);
        }

      });

    }
  };
}])