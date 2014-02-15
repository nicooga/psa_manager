class Activity < ActiveRecord::Base
  belongs_to :address
  belongs_to :contact
  belongs_to :user

  TYPES = %w| DemoArrangement SaleArrangement ServiceArrangement ExchangeArrangement
   InvitationArrangement PresentationArrangement EntryMonitoringArrangement EntryArrangement
   Demo Sale Service Exchange Invitation Presentation EntryMonitoring Entry|

  STATUSES = [:pending, :failed, :completed]

  validates :target_date, :type, :contact, presence: true

  # Logic for generating next activities
  def next_activity() @next_activities end
  def next_activity=(value)
    @next_activities = value
  end

  COMPLETITION_CONDITIONS = ->(a) do
    !status_changed? || !status_change.map(&:to_s).uniq.one? && status.to_s == 'completed'
  end

  after_update :reschedule, if: ->(a) do
    !a.status_changed? || !a.status_change.map(&:to_s).uniq.one? && a.status.to_s == 'failed'
  end

  before_update :set_completed_date, if: COMPLETITION_CONDITIONS
  after_update :generate_next_activity, if: COMPLETITION_CONDITIONS

  private

  def reschedule() end
  def generate_next_activity() end
  def set_completed_date
    self.completed_date = Time.now if valid?
  end
end
