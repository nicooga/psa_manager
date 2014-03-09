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
#= require initializers
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

  window.get_phone_number_info = (number, func)->
    $.ajax
      url: "http://www.paginasblancas.com.ar/Telefono/#{number}",
      type: 'GET',
      success: (res)->
        try
          $html = $(res.responseText).find('.resultBoxContent')
          name = $html.find('.advertise-name').text()
          match = try
            $html.find('.advertiseBlockContent').text()
              .match /\n(.+?),.*CP:(\d+).*-\s(.+?)\n/
          catch
            {}

          func
            name:     titleize(name)
            address:  titleize(match[1])
            zip_code: titleize(match[2])
            city:     titleize(match[3])
        catch
          func false

  window.append_phone_info_to = (e, info)->
    if info
      $.each info, (key, value)->
        e.find("[data-info='#{key}']").text(value)
    else
      e.html $('<div class="alert alert-warning">No info found</div>')

  # window.spin_on = (e)->
    # spinner_spot = $('<div class="spinner_spot">')
    # e.append spinner_spot
    # spinner_spot.spin()

  # window.stop_spinning_on = (e)->
    # e.find('.spinner_spot').spin false

  $(document).ready -> $.each window.initializers, (_, initializer)-> initializer()
