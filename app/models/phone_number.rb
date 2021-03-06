class PhoneNumber < ActiveRecord::Base
  belongs_to :address
  belongs_to :contact

  scope :without_address, -> { where address_id: nil }
  KINDS = %w|Home Work Cellphone Other|

  accepts_nested_attributes_for :contact,
    reject_if: ->(attrs) do
      (Contact.attribute_names - %w|id user_id created_at updated_at|).all? { |attr|
        attrs[attr].blank?
      }
    end

  validates :number, presence: true
  validates :number, numericality: {
    greater_than_or_equal_to: 10_000_000,
    less_than_or_equal_to: 99_999_999
  }

  # TODO: change this virtual attributes into actual db columns
  def country_code() "+54" end
  def prefix() '011' end

  def join(*attr_names)
    attr_names.map(&method(:try)).join
  end
end
