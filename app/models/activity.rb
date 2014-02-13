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
  def next_activities() @next_activities end
  def next_activities=(value)
    @next_activities = value
  end

  COMPLETITION_CONDITIONS = ->(a) do
    !status_changed? || !status_change.map(&:to_s).uniq.one? && status.to_s == 'completed'
  end


  after_update :reschedule, if: ->(a) do
    !status_changed? || !status_change.map(&:to_s).uniq.one? && status.to_s == 'failed'
  end

  after_update :generate_next_activities, if: COMPLETITION_CONDITIONS
  before_update :set_completed_date, if: COMPLETITION_CONDITIONS

  private

  def reschedule() end
  def generate_next_activities() end
  def set_completed_date
    self.completed_date = Time.now if valid?
  end
end
