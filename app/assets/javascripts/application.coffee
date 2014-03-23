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
#= require jquery.spin
#= require underscore
#= require gmaps/google
#= require bootstrap
#= require cocoon
#= require cross_domain_ajax
#= require paginas_blancas_scrapping
#= require initializers
#= require bootstrap-select
#= require_tree .
$ ->
  window.titleize = titleize = (str)->
    return unless str
    words = str.split(" ")
    array = []
    i = 0
    while i < words.length
      array.push words[i].charAt(0).toUpperCase() + words[i].toLowerCase().slice(1)
      ++i
    array.join " "

  window.run_initializers = ->
    $.each window.initializers, (_, initializer)-> initializer()

  $(document).ready -> run_initializers()
