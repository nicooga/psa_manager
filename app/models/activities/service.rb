class Service < Activity
  belongs_to :installation
  validates :installation, presence: true

  private

  def reschedule
    self.next_activity = ServiceArrangement.new(
      contact:      self.contact,
      user:         self.user,
      address:      self.address,
      installation: self.installation
    )
  end

  def generate_next_activity
    next_activity_type = installation.warranty_about_to_expire? ?
      ExchangeArrangement : ServiceArrangement
    self.next_activity = next_activity_type.new(
      contact:      self.contact,
      user:         self.user,
      address:      self.address,
      installation: self.installation,
      target_date:  self.installation.warranty_expiration_date - 1.week
    )
  end
end
