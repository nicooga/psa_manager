class PhoneNumber < ActiveRecord::Base
  belongs_to :address
  belongs_to :contact

  KINDS = %w|Home Work Cellphone Other|

  validates :number, presence: true
end
