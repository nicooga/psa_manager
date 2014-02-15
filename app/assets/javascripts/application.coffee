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
#= require bootstrap
#= require_tree .

$ -> $(document).ready ->
  $(".input-group.datepicker").datetimepicker pickTime: false, format: 'YYYY/MM/DD'
  $(".input-group.datetimepicker").datetimepicker
    format:          'yyyy-mm-dd hh:mm',
    autoclose:       true,
    todayBtn:        true,
    pickerPosition:  "bottom-left"
    triggerSelector: '.input-group-addon .glyphicon.glyphicon-calendar',
    resetSelector:   '.input-group-addon .glyphicon.glyphicon-remove',
