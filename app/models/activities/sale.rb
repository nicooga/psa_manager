class Sale < Activity
  belongs_to :installation
  accepts_nested_attributes_for :installation, reject_if: :all_blank
  validates :installation, presence: true, on: :update, if: :just_completed?

  def needs_an_installation?() true end

  def next_activity
    case status
    when :completed
      ServiceArrangement.new(
        contact:      self.contact,
        user:         self.user,
        address:      self.address,
        installation: self.installation,
        target_date:  self.installation.next_service_date - 1.week
      )
    when :failed
      SaleArrangement.new(
        contact: self.contact,
        user:    self.user,
        address: self.address
      )
    end
  end
end
