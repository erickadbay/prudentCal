# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require fullcalendar
$(document).ready ->
  $("#calendar").fullCalendar(
    events: 'events.json'
  )
  $('#submitbtn').click (evt) ->
    if !checkForm('event_title')
      evt.preventDefault()
      alert 'Please provide an event title and submit again.'
      return false
    $('form#submitbtn').submit()
    return
  return

checkForm = (id) ->
   if $('#' + id).val() == null or $('#' + id).val() == ''
     false
   else
     true
