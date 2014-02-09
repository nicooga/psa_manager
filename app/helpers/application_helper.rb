module ApplicationHelper
  include Bootstrap3::HelperMethods

  def add_fields_button(form, selector, partial, options = {})
    opts = { partial_opts: {},
             button: icon('plus-sign'),
             class: 'btn',
             timestamp_name: :timestamp }.merge(options)
    html = j render(partial, { form: form }.merge(opts[:partial_opts]))
    script = <<-STR
      timestamp = (new Date).getTime();
      $('#{selector}').append('#{html}'.replace(/-#{opts[:timestamp_name]}(_\\d+)?-/g, '_' + timestamp))
    STR
    link_to_function opts[:button], script, class: opts[:class]
  end

  def remove_fields_button(form, selector = nil, options = {})
    field = j form.hidden_field(:_destroy, value: true)
    selector = selector ? "$('#{selector}')" : "$(this).parent()"
    script = <<-STR
      #{selector}.append('#{field}');
      #{selector}.fadeOut(400)
    STR
    icon = icon('remove-sign')
    link_to_function(icon, script, class: options[:class] || 'btn pull-right')
  end

end
