class ContactDecorator < Draper::Decorator
  delegate_all

  def full_name
    [object.first_name, last_name].join ' '
  end
end
