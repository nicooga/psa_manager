class Kit < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates :serial_number, :aquisition_date, :product, presence: true
end
