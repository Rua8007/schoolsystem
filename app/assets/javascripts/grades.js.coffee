# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'page:change', ->
  $('body').on 'click', '.select-subject' , ->
    if $(this).prop('checked')
      $(this).parents('.row').find('input[type="text"]').attr('required', 'true')
    else
      $(this).parents('.row').find('input[type="text"]').attr('required', 'false')

