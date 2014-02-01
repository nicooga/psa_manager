class PhoneNumber < ActiveRecord::Base
  belongs_to :address
  belongs_to :contact

  scope :without_address, -> { where address_id: nil }

  KINDS = %w|Home Work Cellphone Other|

  validates :number, presence: true
end
