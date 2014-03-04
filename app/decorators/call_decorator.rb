class CallDecorator < Draper::Decorator
  include ActionView::Helpers::TagHelper
  delegate_all

  def status(options = {})
    opts = { class: css_class_for(object.status) }
    merge_opts(opts, class: 'rest-in-place',
      data: { attribute: :status }
    ) if options[:rest_in_place]

    puts opts.inspect

    content_tag(:span, object.status, opts)
  end

  private

  def css_class_for(status)
    (@css_classes ||= {
      pending:   'label label-default',
      failed:    'label label-danger',
      completed: 'label label-success'
    }.with_indifferent_access)[status]
  end

  def merge_opts(hash, options)
    hash.merge(options) do |k, old, new|
      case k
      when :class then [old, new].map(&:to_s).join(' ')
      else new
      end
    end
  end
end
