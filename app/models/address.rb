class Address < ActiveRecord::Base
  belongs_to :contact
  has_many :phone_numbers

  accepts_nested_attributes_for :phone_numbers, allow_destroy: true, reject_if: :all_blank
  geocoded_by :full_address
  after_validation :geocode, if: :needs_geocoding?

  validates :city, :state, :street, :number, presence: true
  STATES = Carmen::Country.coded('AR').subregions.map(&:name)

  private

  def full_address
    [state, city, [street, number].join(' ')].join(', ')
  end

  def needs_geocoding?
    %i|state city street number|.map do |attr|
      !try(attr).present? || send("#{attr}_changed?")
    end
  end
end
