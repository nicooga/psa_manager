class Address < ActiveRecord::Base
  belongs_to :contact
  validates :city, :state, :street, :number, :contact, presence: true
  STATES = Carmen::Country.coded('AR').subregions.map(&:name)
end
