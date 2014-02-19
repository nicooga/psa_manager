class Activity < ActiveRecord::Base
  belongs_to :address
  belongs_to :contact
  belongs_to :user

  TYPES = %w| DemoArrangement SaleArrangement ServiceArrangement ExchangeArrangement
   InvitationArrangement PresentationArrangement EntryMonitoringArrangement EntryArrangement
   Demo Sale Service Exchange Invitation Presentation EntryMonitoring Entry|

  STATUSES = [:pending, :failed, :completed]

  validates :target_date, :type, :contact, :address, presence: true

  default_scope -> { order 'target_date DESC' }

  before_update :set_completed_date, if: :just_completed?

  def needs_an_installation?() false end

  def just_completed?
    !status_changed? ||
    !status_change.map(&:to_s).uniq.one? &&
    status.to_s == 'completed'
  end

  STATUSES.each do |status|
    define_method :"#{status}?" do
      self.status = status
    end
  end

  private

  def set_completed_date
    self.completed_date = Time.now if valid?
  end
end
