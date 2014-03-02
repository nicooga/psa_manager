# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require jquery.turbolinks
#= require underscore
#= require gmaps/google
#= require bootstrap
#= require cocoon
#= require_tree .

window.init_datepickers = ->
  $(".input-group.datepicker").datetimepicker
    pickTime:        false,
    format:          'yyyy-mm-dd',
    autoclose:       true,
    todayBtn:        true,
    pickerPosition:  "bottom-left"
    triggerSelector: '.input-group-addon .glyphicon.glyphicon-calendar',
    resetSelector:   '.input-group-addon .glyphicon.glyphicon-remove',

window.init_datetimepickers = ->
  $(".input-group.datetimepicker").datetimepicker
    format:          'yyyy-mm-dd hh:mm',
    autoclose:       true,
    todayBtn:        true,
    pickerPosition:  "bottom-left",
    triggerSelector: '.input-group-addon .glyphicon.glyphicon-calendar',
    resetSelector:   '.input-group-addon .glyphicon.glyphicon-remove',

$ ->
  $(document).ready ->
    window.init_datetimepickers()
    window.init_datepickers()

    $('.input-group .reset').click ->
      $(this).parent().find('input[type!="submit"]').val('')
      $(this).parent().parent().submit()

  $(document).on 'cocoon:before-insert', (e, inserted_item)->
    new_id = new Date().getTime()
    html = inserted_item.html()
    inserted_item.html html.replace(/\-timestamp\-/g, new_id)
