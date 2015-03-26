// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require angular/app
//= require bootstrap.min
//= require pixel-admin.min
//= require select.min
//= require_tree .

$(document).ready(function(){

  $('form').on('click', '.remove_fields', function(event) {

    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('.fieldset').children("td").addClass("alert alert-warning");
    
    $(this).children(".fa-times").removeClass("fa-times").addClass("fa-refresh");
    $(this).removeClass("remove_fields").addClass("restore_fields");

    event.preventDefault();
  });

  $('form').on('click', '.restore_fields', function(event) {

    $(this).prev('input[type=hidden]').val('0');
    $(this).closest('.fieldset').children("td").removeClass("alert alert-warning");

    $(this).children(".fa-refresh").removeClass("fa-refresh").addClass("fa-times");
    $(this).removeClass("restore_fields").addClass("remove_fields");
  
    event.preventDefault();
  });

  $('form').on('click', '.add_fields', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).parents(".append-fields-parent").children(".append-fields-container").append($(this).data('fields').replace(regexp, time));
    
    event.preventDefault();
  });

});
