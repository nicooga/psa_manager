class ColdList < ActiveRecord::Base
  belongs_to :user
  belongs_to :responsible, class_name: 'User'
  has_many :calls, dependent: :destroy
  has_many :phone_numbers, through: :calls

  accepts_nested_attributes_for :calls,
    allow_destroy: true, reject_if: :all_blank

  validates :phone_number_prefix, presence: true

  def next_phone_number
    numbers = phone_numbers.reorder(:number)
      .pluck('DISTINCT("phone_numbers"."number")')
    possible_numbers = ((pnp * 10_000)..(pnp * 10_000 + 9999)).to_a
    (possible_numbers - numbers).first
  end

  alias_attribute :pnp, :phone_number_prefix
end
