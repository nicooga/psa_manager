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

  def scope_buttons(*scopes)
    opts = {
      class: 'btn btn-base btn-default',
      remote: false,
      params: { controller:  controller_path }
    }.merge(scopes.extract_options!)

    css_class = current_scopes.none? ? opts[:class] + ' active' : opts[:class]
    link_to(icon('zoom-out'), opts[:params], class: css_class, remote: opts[:remote]) +
    scopes.map do |scp|
      css_class = current_scopes.keys.include?(scp) ? opts[:class] + ' active' : opts[:class]
      link_to scp.to_s.titleize, Hash[scp, true].merge(opts[:params]), class: css_class, remote: opts[:remote]
    end.reduce(:+)
  end

  def table(collection, attributes_hash)
    content_tag(:table, class: 'table table-condensed') do
      content_tag(:thead)
    end
  end
end

module Bootstrap3
  class FormBuilder < ActionView::Helpers::FormBuilder
    include Bootstrap3::HelperMethods
    include ActionView::Helpers::TagHelper

    [:text_field, :text_area, :number_field].each do |method_name|
      define_method method_name do |field, opts = {}|
        opts = merge_opts(opts, input_group: true) if opts[:addon]
        html = super(field, merge_opts(opts,
          placeholder: object.class.try(:human_attribute_name, field),
          class: 'form-control'
        ))
        input_wrapping html, opts
      end
    end

    def select(field, choices, opts = {}, html_opts = {})
      html = super field, choices, merge_opts(opts,
        input_group: true,
        include_blank: object.class.human_attribute_name(field)
      ), merge_opts(html_opts, class: 'form-control')
      input_wrapping html, opts
    end

    def datepicker(field, opts = {})
      html = text_field field
      input_wrapping html, merge_opts(opts,
        input_group: { class: 'datepicker date' },
        addon: ['#', :remove, :calendar],
        class: :date
      )
    end

    def datetimepicker(field, opts = {})
      html = text_field field
      opts = merge_opts(opts,
        input_group: { class: 'datetimepicker date' },
        addon: ['#', :remove, :calendar],
        class: :date
     )
     input_wrapping(html, opts)
    end

    def input_wrapping(html, opts = {})
      html = input_group_wrapping(html, opts)
    end

    def input_group_wrapping(html, opts = {})
      html = addon_rendering(html, opts[:addon])
      css_class = [opts[:input_group].try(:[], :class), 'input-group'].compact.join(' ')
      opts[:input_group] ? content_tag(:div, html, class: css_class) : html
    end

    def addon_rendering(html, opts = {})
      case opts
      when String, Symbol
        input_group_addon(opts) + html
      when Hash
        input_group_addon(opts[:before]) + html + input_group_addon(opts[:after])
      when Array
        opts.map do |icon_name|
          icon_name.to_s == '#' ? html : input_group_addon(icon_name)
        end.reduce(:+)
      else
        html
      end
    end

    def input_group_addon(opts)
      case opts
      when String, Symbol
        content_tag(:span, icon(opts), class: 'input-group-addon')
      when Hash
        css_class = [opts[:class], 'input-group-addon'].compact.join(' ')
        content_tag(:span, icon(opts[:icon_name]), class: css_class)
      end
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
end
