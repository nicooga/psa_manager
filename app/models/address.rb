class Address < ActiveRecord::Base
  belongs_to :contact
  has_many :phone_numbers

  accepts_nested_attributes_for :phone_numbers, allow_destroy: true, reject_if: :all_blank

  validates :city, :state, :street, :number, presence: true
  STATES = Carmen::Country.coded('AR').subregions.map(&:name)
end
