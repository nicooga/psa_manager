class UserDecorator < Draper::Decorator
  delegate_all


  def to_s
    email
  end
end
