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

  input_reset_buttons: ->
    $('[data-reset]').click ->
      $form = $(this).closest('form').closest('form')
      $form.find('input[type=text]').val('')
      $form.submit()

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

  tooltips: -> $('[data-toggle=tooltip]').tooltip()

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

  populate_phone_number_info_displays: (selector)->
    $.each (selector || $('[data-phone-number-info]')), (i,e)->
      $e = $(e)
      $e.addClass 'opaque'
      $e.spin()
      get_phone_number_info $e.data('phone-number-info'), (info)->
        append_phone_info_to $e, info
        $e.removeClass 'opaque'
        $e.spin false

  input_group_decrease_buttons: ->
    $('.input-group-btn [data-decrease]').click ->
      $input = $(this).closest('.input-group').find('input')
      $input.val parseInt($input.val()) - 1

  input_group_increase_buttons: ->
    $('.input-group-btn [data-increase]').click ->
      $input = $(this).closest('.input-group').find('input')
      $input.val parseInt($input.val()) + 1

  call_form_increase_buttons: ->
    $('[data-increase], [data-decrease]').click ->
      $this = $(this)
      $form = $this.closest('form')
      number = $form.find('#call_phone_number_attributes_number').val()
      $container = $this.closest('form').find('[data-phone-number-info]')
      $container.data('phone-number-info' , "011#{number}")

      initializers.populate_phone_number_info_displays($container)

  checbox_toggle_buttons: ->
    $('[data-checkbox-toggle]').click ->
      selector = $(this).data('checkbox-toggle')
      $.each $(selector), (i,e)->
        $(e).prop 'checked', !$(e).prop('checked')
