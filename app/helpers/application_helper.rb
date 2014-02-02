module ApplicationHelper
  def add_fields_button(form, selector, partial, options = Hash.new({}))
    html = j render(partial, { form: form }.merge(options[:partial_opts] || {}))
    script = <<-STR
      timestamp = (new Date).getTime();
      $('#{selector}').append('#{html}'.replace(/-timestamp(_\\d+)?-/g, '_' + timestamp))
    STR
    link_to_function options[:button] || icon('plus-sign'), script, class: options[:class] || 'btn'
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
    content_tag :i, content, class: "glyphicon glyphicon-#{icon_name}"
  end
end

class PsaManager::FormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper
  include ApplicationHelper

  [:text_field, :text_area, :number_field].each do |method_name|
    define_method method_name do |field, opts = {}|
      opts.merge!(
        placeholder: object.class.human_attribute_name(field),
        class: 'form-control',
        group: true,
        include_blank: object.class.human_attribute_name(field)
      ) do |key, old, new|
        case key
        when :class then [old, new].join(' ')
        when :group then old
        end
      end

      input_wrapping super(field, opts), opts
    end
  end

  def select(field, choices, opts = {}, html_options = {})
    html = super field, choices, opts, html_options.merge(
      placeholder: object.class.human_attribute_name(field),
      class: 'form-control'
    )
    input_wrapping html
  end

  def datepicker(field, opts = {})
    html = @template.content_tag(:div, class: 'form-group') do
      text_field field, opts.merge(class: :datepicker, addon: :th)
    end
    input_wrapping html
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
end
