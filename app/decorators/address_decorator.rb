class AddressDecorator < Draper::Decorator
  delegate_all

  def to_s
    [state, city, [street, number].join(' '), apartment].reject(&:blank?).join ', '
  end

  def short_display
    [street, number].join(' ')
  end
end
