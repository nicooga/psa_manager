class ActivityDecorator < Draper::Decorator
  include ActionView::Helpers::TagHelper
  delegate_all

  def address
    object.address.decorate if object.address
  end

  def target_date
    object.target_date.try :strftime, '%a, %Y-%b-%d %H %R'
  end

  def completed_date
    object.completed_date.strftime('%a, %Y-%b-%d %R') if object.completed_date
  end

  def type
    object.type.titleize
  end

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
