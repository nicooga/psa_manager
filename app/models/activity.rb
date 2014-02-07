class Activity < ActiveRecord::Base
  belongs_to :address
  belongs_to :contact
  belongs_to :user

  TYPES = %w| DemoArrangement SaleArrangement ServiceArrangement ExchangeArrangement
   Invitation PresentationArrangement EntryMonitoringArrangement EntryArrangement
   Demo Sale Service Exchange Invitation Presentation EntryMonitoring Entry|

  STATUSES = [:pending, :failed, :completed]

  validates :target_date, :type, :contact, presence: true
end
