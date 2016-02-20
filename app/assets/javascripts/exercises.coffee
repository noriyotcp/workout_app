# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('#workout-date').datepicker dateFormat: 'yy-mm-dd'

  new (Morris.Line)(
    element: 'chart'
    data: $('#chart').data('workouts')
    xkey: 'workout_date'
    ykeys: [ 'duration_in_min' ]
    labels: [ 'Duration (min)' ]
    xLabels: 'day'
    xLabelAngle: 60
    xLabelFormat: (x) ->
      date_string = x.getFullYear() + '/' + parseInt(x.getMonth() + 1) + '/' + x.getDate()
      date_string
    yLabelFormat: (y) ->
      y + ' min'
  )
  return
