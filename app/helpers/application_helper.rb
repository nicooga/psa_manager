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
    i = content_tag(:span, nil, class: "glyphicon glyphicon-#{icon_name}")
    content ? i + content_tag(:span, ' ' + content) : i
  end
end

class PsaManager::FormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::TagHelper
  include ApplicationHelper

  [:text_field, :text_area, :number_field].each do |method_name|
    define_method method_name do |field, opts = {}|
      html = super(field, merge_opts(opts,
        placeholder: object.class.human_attribute_name(field),
        class: 'form-control'
      ))
      input_wrapping html, opts
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

  def datetimepicker(field, opts = {})
    html = text_field field, merge_opts(opts, class: :datetimepicker)
    input_wrapping(html, merge_opts(opts, addon: {
      before: :calendar,
      after:  :remove
    }))
  end

  private

  def input_wrapping(html, opts = {})
    html = addon_wrapping(html, opts[:addon])

    if opts[:group]
      @template.content_tag :div, class: 'form-group' do
        html
      end
    else
      html
    end
  end

  def addon_wrapping(html, opts = {})
    opts ? @template.content_tag(:div, class: 'input-group') do
      case opts
      when String, Symbol
        input_group_addon(opts) + html
      when Hash
        input_group_addon(opts[:before]) + html + input_group_addon(opts[:after])
      when Array
        opts.map do |icon_name|
          icon_name.to_s == '#' ? html :
            input_group_addon(icon_name)
        end
      end
    end : html
  end

  def input_group_addon(icon_name)
    content_tag(:span, icon(icon_name), class: 'input-group-addon')
  end

  def merge_opts(opts, defaults)
    defaults.merge(opts) do |k, old, new|
      k == :class ? [old.to_s, new.to_s].join(' ') : new
    end
  end

  def ignore_opts(opts, *keys)
    opts.dup.delete_if {|k| keys.include? k }
  end
end
