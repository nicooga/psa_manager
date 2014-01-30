module ApplicationHelper
  def add_fields_button(form, selector, partial, options = {})
    html = j render(partial, form: form)
    script = <<-STR
      $('#{selector}').append('#{html}')
    STR
    icon = content_tag :i, nil, class: 'glyphicon glyphicon-plus-sign'
    link_to_function options[:button] || icon, script, class: options[:class]
  end

  def remove_fields_button(form)
    field = j form.hidden_field(:_destroy, value: true) if form.object.persisted?
    script = <<-STR
      $(this).parent().append('#{field}')
      $(this).parent().fadeOut(400)
    STR
    icon = content_tag :i, nil, class: 'glyphicon glyphicon-remove'
    link_to_function icon, script, class: 'pull-right'
  end
end
