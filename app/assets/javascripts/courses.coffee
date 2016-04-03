# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#submitbtn').click (evt) ->
    if !checkForm('course_course_name')
      evt.preventDefault()
      alert 'Please provide a course name and submit again.'
      return false
    $('form#submitbtn').submit()
    return
  return

checkForm = (id) ->
   if $('#' + id).val() == null or $('#' + id).val() == ''
     false
   else
     true
