class ActivityDecorator < Draper::Decorator
  delegate_all

  def address
    object.address.decorate if object.address
  end

  def target_date
    object.target_date.try :strftime, '%Y-%b-%d %H %R'
  end

  def completed_date
    object.completed_date.strftime('%Y-%b-%d %H') if object.completed_date
  end

  def type
    object.type.titleize
  end

  def status
    h.content_tag :span, object.status, class: css_class_for(object.status)
  end

  def contact_link(opts = {})
    c = object.contact
    h.link_to c.decorate, h.user_contact_path(c.user, c), opts
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
