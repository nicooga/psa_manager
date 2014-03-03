class CallDecorator < Draper::Decorator
  include ActionView::Helpers::TagHelper
  delegate_all

  def status
    content_tag :span, object.status, class: css_class_for(object.status)
  end

  private

  def css_class_for(status)
    @css_classes ||= ({
      pending:   'label label-default',
      failed:    'label label-danger',
      completed: 'label label-success'
    }.with_indifferent_access)[status]
  end
end
