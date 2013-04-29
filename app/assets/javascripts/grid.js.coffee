# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

  #something here from the grid.css is wrong. change to what?
$ ->
$('.grid .entry > img').click ->
$(this).parent().find(':submit').click()