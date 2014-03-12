class Activity < ActiveRecord::Base
  include Statusable
  has_statuses :pending, :failed, :completed

  belongs_to :address
  belongs_to :contact
  belongs_to :user
  default_scope -> { order 'target_date ASC' }

  scope :today, -> { where target_date: Date.today..(Date.today + 1.day) }
  scope :older_than, ->(seconds) do
    where arel_table[:completed_date].lteq(Time.now.advance(seconds: -seconds))
  end

  TYPES = %w| DemoArrangement SaleArrangement ServiceArrangement ExchangeArrangement
   InvitationArrangement PresentationArrangement EntryMonitoringArrangement EntryArrangement
   Demo Sale Service Exchange Invitation Presentation EntryMonitoring Entry|

  validates :target_date, :type, :contact, :address, presence: true

  before_update :set_completed_date, if: :just_completed?

  def needs_an_installation?() false end
  def just_completed?
    !status_changed? ||
    !status_change.map(&:to_s).uniq.one? &&
    status.to_s == 'completed'
  end

  private

  def set_completed_date
    self.completed_date = Time.now if valid?
  end
end
