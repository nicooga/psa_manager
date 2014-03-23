class Call < ActiveRecord::Base
  include Statusable
  default_scope -> { order(created_at: :desc) }
  has_statuses :positive, :negative, :skipped, :pending

  belongs_to :cold_list
  belongs_to :phone_number

  counter_culture :cold_list, column_name: ->(c) { "#{c.status}_calls_count" },
    column_names: Hash[Call.statuses.map do |sts|
      [arel_table[:status].eq(sts), "#{sts}_calls_count"]
    end]

  accepts_nested_attributes_for :phone_number,
    allow_destroy: true, reject_if: :all_blank, update_only: true

  validates :phone_number, presence: true
end
