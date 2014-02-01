class ContactDecorator < Draper::Decorator
  delegate_all

  def full_name
    [first_name, last_name].join ' '
  end

  def source
    object.source if object.source_id
  end

  def to_s() full_name end
end
