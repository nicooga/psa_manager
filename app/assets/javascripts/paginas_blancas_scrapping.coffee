$ ->
  window.get_phone_info = (number)->
    $.ajax url: "http://www.paginasblancas.com.ar/Telefono/#{number}",
      beforeSend: (req)->
        req.addRequestHeader('Access-Control-Allow-Origin', window.location)
      success: (msg)->
        console.log msg
