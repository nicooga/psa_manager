class Demo < Activity
  def reschedule
    self.next_activity = DemoArrangement.new(
      contact_id: self.contact_id,
      user_id:    self.user_id,
      address_id: self.address_id
    )
  end

  def generate_next_activity
    self.next_activity = {
      one_of: [Sale, SaleArrangement].map do |a|
        a.new(
          contact_id: self.contact_id,
          user_id:    self.user_id,
          address_id: self.address_id
        )
      end
    }
  end
end
