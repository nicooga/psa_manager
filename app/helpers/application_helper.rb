module ApplicationHelper
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

  def icon(icon_name, content = nil)
    i = content_tag(:i, nil, class: "glyphicon glyphicon-#{icon_name}")
    content ? i + content_tag(:span, ' ' + content) : i
  end
end

class PsaManager::FormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper
  include ApplicationHelper

  [:text_field, :text_area, :number_field].each do |method_name|
    define_method method_name do |field, opts = {}|
      merge_opts(opts,
        placeholder: object.class.human_attribute_name(field),
        class: 'form-control',
        group: true
      )

      input_wrapping super(field, opts), opts
    end
  end

  def select(field, choices, opts = {}, html_opts = {})
    html = super field, choices, merge_opts(opts,
      group: true,
      include_blank: object.class.human_attribute_name(field)
    ), merge_opts(html_opts, class: 'form-control')
    input_wrapping html, opts
  end

  def datepicker(field, opts = {})
    html = @template.content_tag(:div, class: 'form-group') do
      text_field field, opts.merge(class: :datepicker, addon: :calendar)
    end
    input_wrapping html, opts
  end

  private

  def input_wrapping(html, opts = {})
    html = if opts[:addon]
      @template.content_tag(:div, class: 'input-group') do
        content_tag(:span, icon(opts[:addon]), class: 'input-group-addon') + html
      end
    else
      html
    end

    if opts[:group]
      @template.content_tag :div, class: 'form-group' do
        html
      end
    else
      html
    end
  end

  def merge_opts(opts, defaults)
    opts.merge!(defaults) do |key, old, new|
      case key
      when :class then [old, new].join(' ')
      when :group then old
      else old || new
      end
    end
  end
end
