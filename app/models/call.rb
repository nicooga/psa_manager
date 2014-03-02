class Call < ActiveRecord::Base
  include Statusable
  has_statuses :pending, :failed, :completed

  belongs_to :cold_list
  belongs_to :phone_number

  accepts_nested_attributes_for :phone_number,
    allow_destroy: true, reject_if: :all_blank

  validates :phone_number, presence: true
end
