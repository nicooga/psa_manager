$ ->
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
