class KitDecorator < Draper::Decorator
  delegate_all

  def to_s
    object.product.name
  end
end
