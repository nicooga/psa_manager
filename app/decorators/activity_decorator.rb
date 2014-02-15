class ActivityDecorator < Draper::Decorator
  delegate_all

  def contact
    object.contact.decorate.full_name
  end

  def address
    object.address.decorate if object.address
  end
end
