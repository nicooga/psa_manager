class Product < ActiveRecord::Base
  monetize :list_price_cents
  monetize :suggested_price_cents

  validates :name, :expiration_time, presence: true
end
