class Installation < ActiveRecord::Base
  belongs_to :kit
  belongs_to :contact
  belongs_to :address
  belongs_to :user

  validates :address, :contact, :kit, presence: true
end
