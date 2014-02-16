class ExchangeArrangement < Activity
  belongs_to :installation
  validates :installation, presence: true

  private

  def reschedule
    self.next_activity = ExchangeArrangement.new(
      contact:      self.contact,
      user:         self.user,
      address:      self.address,
      installation: self.installation
    )
  end

  def generate_next_activity
    self.next_activity = Exchange.new(
      contact:      self.contact,
      user:         self.user,
      address:      self.address,
      installation: self.installation
    )
  end
end
