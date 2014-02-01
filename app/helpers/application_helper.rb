module ApplicationHelper
  def add_fields_button(form, selector, partial, options = Hash.new({}))
    html = j render(partial, { form: form }.merge(options[:partial_opts] || {}))
    script = <<-STR
      timestamp = (new Date).getTime();
      $('#{selector}').append('#{html}'.replace(/-timestamp(_\d+)?-/g, '_' + timestamp))
    STR
    icon = content_tag :i, nil, class: 'glyphicon glyphicon-plus-sign'
    link_to_function options[:button] || icon, script, class: options[:class]
  end

  def remove_fields_button(form, selector = nil, options = {})
    field = j form.hidden_field(:_destroy, value: true)
    selector = selector ? "$('#{selector}')" : "$(this).parent()"
    script = <<-STR
      #{selector}.append('#{field}');
      #{selector}.fadeOut(400)
    STR
    icon = content_tag :i, nil, class: 'glyphicon glyphicon-remove'
    link_to_function(icon, script, class: options[:class] || 'pull-right')
  end
end
