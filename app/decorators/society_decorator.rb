class SocietyDecorator < Draper::Decorator
  delegate_all

  def created_at
    object.created_at.try :strftime, '%Y %b %d'
  end
end
