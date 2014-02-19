class ExchangeArrangement < Activity
  belongs_to :installation
  validates :installation, presence: true

  def next_activity
    case status
    when :completed
      Exchange.new(
        contact:      self.contact,
        user:         self.user,
        address:      self.address,
        installation: self.installation
      )
    when :failed
      ExchangeArrangement.new(
        contact:      self.contact,
        user:         self.user,
        address:      self.address,
        installation: self.installation
      )
    end
  end
end
