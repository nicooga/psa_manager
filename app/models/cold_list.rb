class ColdList < ActiveRecord::Base
  belongs_to :user
  belongs_to :responsible, class_name: 'User'
  has_many :calls, dependent: :destroy
  has_many :phone_numbers, through: :calls

  accepts_nested_attributes_for :calls,
    allow_destroy: true, reject_if: :all_blank

  validates :phone_number_prefix, presence: true

  scope :with_pending_calls, -> do
    joins(:calls).where calls: { status: :pending }
  end

  def next_phone_number
    numbers = phone_numbers.reorder(:number)
      .pluck('DISTINCT("phone_numbers"."number")')
    ((pnp * 10_000)..(pnp * 10_000 + 9999)).find { |e| not numbers.include? e }
  end

  alias_attribute :pnp, :phone_number_prefix
end
