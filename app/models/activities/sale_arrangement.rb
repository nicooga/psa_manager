class SaleArrangement < Activity
  def next_activity
    case status
    when :completed
      Sale.new(
        contact: self.contact,
        user:    self.user,
        address: self.address
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
