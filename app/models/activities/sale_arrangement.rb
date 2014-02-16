class SaleArrangement < Activity
  private

  def reschedule
    self.next_activity = SaleArrangement.new(
      contact: self.contact,
      user:    self.user,
      address: self.address
    )
  end

  def generate_next_activity
    self.next_activity = Sale.new(
      contact: self.contact,
      user:    self.user,
      address: self.address
    )
  end
end
