# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require fullcalendar

$(document).ready ->
    if $(window).width() > 800
        $("#calendar").fullCalendar(
            events: 'events.json'
            header:
                left: 'prev,next today'
                center: 'title'
                right: 'month,agendaWeek,agendaDay'
            eventLimit: true, 5
        )
    else
        $("#calendar").fullCalendar(
            events: 'events.json'
            defaultView: 'agendaWeek'
            height: 450
            header:
                left: 'prev,next today'
                center: 'title'
                right: 'month,agendaWeek,agendaDay'
            eventLimit: true, 5
        )
    
