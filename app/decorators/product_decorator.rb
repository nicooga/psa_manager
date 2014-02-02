class ProductDecorator < Draper::Decorator
  include MoneyRails::ActionViewExtension
  delegate_all

  def list_price_with_symbol
    humanized_money_with_symbol object.list_price
  end

  def suggested_price_with_symbol
    humanized_money_with_symbol object.suggested_price
  end
end
