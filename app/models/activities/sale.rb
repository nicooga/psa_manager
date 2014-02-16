class Sale < Activity
  belongs_to :installation
  accepts_nested_attributes_for :installation, reject_if: :all_blank
  validates :installation, presence: true, on: :update, if: COMPLETITION_CONDITIONS

  private

  def reschedule
    self.next_activity = SaleArrangement.new(
      contact: self.contact,
      user:    self.user,
      address: self.address
    )
  end

  def generate_next_activity
    self.next_activity = ServiceArrangement.new(
      contact:      self.contact,
      user:         self.user,
      address:      self.address,
      installation: self.installation,
      target_date:  self.installation.next_service_date - 1.week
    )
  end
end
