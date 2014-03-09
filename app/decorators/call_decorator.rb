class CallDecorator < Draper::Decorator
  include ActionView::Helpers::TagHelper
  delegate_all

  def status(options = {})
    content_tag :span, object.status,
      class: css_class_for(object.status)
  end

  def created_at
    object.created_at.try :strftime, '%a, %Y %b %d, %H %R'
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
