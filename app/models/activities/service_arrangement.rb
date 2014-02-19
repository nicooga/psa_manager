class ServiceArrangement < Activity
  belongs_to :installation
  validates :installation, presence: true

  def next_activity
    case status
    when :completed
       Service.new(
        contact:      self.contact,
        user:         self.user,
        address:      self.address,
        installation: self.installation,
        target_date:  self.installation.next_service_date - 1.week
      )
    when :failed
      ServiceArrangement.new(
        contact:      self.contact,
        user:         self.user,
        address:      self.address,
        installation: self.installation,
      )
    end
  end
end
