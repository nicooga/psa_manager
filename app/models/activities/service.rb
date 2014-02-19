class Service < Activity
  belongs_to :installation
  validates :installation, presence: true

  def next_activity
    case status
    when :completed
      next_activity_type = installation.warranty_about_to_expire? ?
        ExchangeArrangement : ServiceArrangement
      next_activity_type.new(
        contact:      self.contact,
        user:         self.user,
        address:      self.address,
        installation: self.installation,
        target_date:  self.installation.warranty_expiration_date - 1.week
      )
    when :failed
      ServiceArrangement.new(
        contact:      self.contact,
        user:         self.user,
        address:      self.address,
        installation: self.installation
      )
    end
  end
end
