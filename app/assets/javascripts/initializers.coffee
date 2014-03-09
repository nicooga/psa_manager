window.initializers =
  datepickers: ->
    $(".input-group.datepicker").datetimepicker
      pickTime:        false,
      format:          'yyyy-mm-dd',
      autoclose:       true,
      todayBtn:        true,
      pickerPosition:  "bottom-left"
      triggerSelector: '.input-group-addon .glyphicon.glyphicon-calendar',
      resetSelector:   '.input-group-addon .glyphicon.glyphicon-remove'

  datetimepickers: ->
    $(".input-group.datetimepicker").datetimepicker
      format:          'yyyy-mm-dd hh:mm',
      autoclose:       true,
      todayBtn:        true,
      pickerPosition:  "bottom-left",
      triggerSelector: '.input-group-addon .glyphicon.glyphicon-calendar',
      resetSelector:   '.input-group-addon .glyphicon.glyphicon-remove'

  cocoon_timestamp_parsing: ->
    $(document).on 'cocoon:before-insert', (e, inserted_item)->
      new_id = new Date().getTime()
      html = inserted_item.html()
      inserted_item.html html.replace(/\-timestamp\-/g, new_id)

  expandable_text_areas: ->
    $('textarea.expand').focus( ->
      $(this).attr 'rows', 4
    ).blur ->
      $(this).attr 'rows', 1

  parent_collapse_hack: ->
    $('[data-toggle="collapse"]').click ->
      $($(this).data('parent')).find('.collapse.in').collapse('hide')

  hide_on_submit_modals: ->
    $('.modal.hide_on_submit input[type="submit"]').click ->
      $this = $(this)
      $('.modal').modal('hide')
      $this.parents().parents('form').submit()

  phone_info_popovers: ->
    $('tr.phone_info_popover').hover(->
      $this = $(this)
      html = $("[data-phone-number-info='#{$this.data('phone-number')}']")
      $this.popover
        html:      true
        content:   html
        title:     'Phone number info'
        trigger:   'hover'
        placement: 'left'
    ).click ->
      $(this).popover('show')

  populate_phone_number_info_displays: ->
    $.each $('[data-phone-number-info]'), (i,e)->
      $e = $(e)
      $e.addClass 'opaque'
      $e.spin()
      window.get_phone_number_info $e.data('phone-number-info'), (info)->
        append_phone_info_to $e, info
        $e.removeClass 'opaque'
        $e.spin false
