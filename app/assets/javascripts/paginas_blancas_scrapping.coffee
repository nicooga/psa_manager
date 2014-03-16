$ ->
  window.get_phone_number_info = (number, func)->
    $.ajax
      url: "http://www.paginasblancas.com.ar/es-ar/telefono/#{number}",
      type: 'GET', success: (res)->
        $html = $(res.responseText).find('.m-results-business-section.info')

        data =
          name:     titleize $html.find('.m-results-business-header a').text()
          address:  titleize $html.find('.m-results-business--address span:first').text()
          locality: titleize $html.find('.m-results-business--address span:last').text()

        func(
          if data.name or data.address or data.locality
            data
          else
            false
        )

  window.append_phone_info_to = (e, info)->
    $data_container = e.find('.data_container')
    $error_container = e.find('.error_container')

    if info
      $data_container.removeClass 'hide'
      $error_container.addClass 'hide'
      $.each info, (key, value)->
        e.find("[data-info='#{key}']").text(value)
    else
      $data_container.addClass 'hide'
      $error_container.removeClass 'hide'
      $error_container.html $('<div class="alert alert-warning">No info found</div>')
