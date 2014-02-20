class ContactDecorator < Draper::Decorator
  delegate_all

  def full_name
    [first_name, last_name].join ' '
  end

  def source
    object.source.decorate.full_name if object.source_id
  end

  def birthday
    object.birthday.strftime('%Y %b %d')
  end

  def to_s() full_name end
end
