$ ->
  $form = $('form#new_activity')

  $form.find('select#activity_contact_id').change ->
    contact_id = $(this).val()

    response = $.get "/contacts/#{contact_id}.json",
      scope:
        only:    'id'
        methods: 'addresses',
      (contact)->
        options_html = [$('<option>').text('Address')].concat(
          $.map(contact.addresses, (address)->
            $('<option>').attr('value', address.id)
            .text([address.state, address.city,
              [address.street, address.number].join(' ')
            ].join(', '))
          )
        )

        $form.find('select#activity_address_id').html options_html
