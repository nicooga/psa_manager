class AddressDecorator < Draper::Decorator
  delegate_all

  def to_s
    [state, city, street, number, apartment].reject(&:blank?).join ', '
  end
end
