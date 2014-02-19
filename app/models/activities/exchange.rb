class Exchange < Activity
  belongs_to :installation
  validates :installation, presence: true

  def next_activity
    case status
    when :completed
      Sale.new(
        contact:      self.contact,
        user:         self.user,
        address:      self.address,
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
